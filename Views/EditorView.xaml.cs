using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;
using Microsoft.Win32;
using MusicGame.Models;
using MusicGame.Services;

namespace MusicGame.Views
{
    /// <summary>
    /// EditorView.xaml 的交互逻辑
    /// </summary>
    public partial class EditorView : UserControl
    {
        private readonly AudioPlayer _audioPlayer;
        private readonly ScoreManager _scoreManager;
        private Score _currentScore;
        private List<Ellipse> _noteShapes;

        public EditorView()
        {
            InitializeComponent();
            InitializeLineComboBox();
            
            _audioPlayer = new AudioPlayer();
            _scoreManager = new ScoreManager();
            _currentScore = new Score();
            _noteShapes = new List<Ellipse>();
        }

        private void InitializeLineComboBox()
        {
            // 初始化六线选择下拉框
            for (int i = 1; i <= 6; i++)
            {
                LineComboBox.Items.Add(i.ToString());
            }
            
            if (LineComboBox.Items.Count > 0)
            {
                LineComboBox.SelectedIndex = 0;
            }
        }

        private void AddNoteButton_Click(object sender, RoutedEventArgs e)
        {
            // 解析输入值
            if (LineComboBox.SelectedIndex == -1 ||
                !double.TryParse(TimeTextBox.Text, out double time) ||
                !double.TryParse(DurationTextBox.Text, out double duration))
            {
                MessageBox.Show("请输入有效的参数", "提示", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            // 创建音符
            int lineIndex = LineComboBox.SelectedIndex;
            Note note = new Note
            {
                LineIndex = lineIndex,
                Time = time,
                Duration = duration
            };

            // 添加到谱面
            _currentScore.Notes.Add(note);
            
            // 绘制音符
            DrawNote(note);
        }

        private void DeleteNoteButton_Click(object sender, RoutedEventArgs e)
        {
            // TODO: 实现删除选中音符的逻辑
            MessageBox.Show("删除功能待实现", "提示", MessageBoxButton.OK, MessageBoxImage.Information);
        }

        private void LoadMusicButton_Click(object sender, RoutedEventArgs e)
        {
            // 打开文件选择对话框
            OpenFileDialog openFileDialog = new OpenFileDialog
            {
                Filter = "音乐文件 (*.mp3;*.wav;*.flac)|*.mp3;*.wav;*.flac|所有文件 (*.*)|*.*",
                Title = "选择音乐文件"
            };

            if (openFileDialog.ShowDialog() == true)
            {
                // 加载音乐
                _audioPlayer.Load(openFileDialog.FileName);
                _currentScore.MusicFilePath = openFileDialog.FileName;
                
                MessageBox.Show("音乐加载成功", "提示", MessageBoxButton.OK, MessageBoxImage.Information);
            }
        }

        private void PlayMusicButton_Click(object sender, RoutedEventArgs e)
        {
            if (_audioPlayer.IsPlaying)
            {
                _audioPlayer.Play();
            }
        }

        private void PauseMusicButton_Click(object sender, RoutedEventArgs e)
        {
            _audioPlayer.Pause();
        }

        private void SaveScoreButton_Click(object sender, RoutedEventArgs e)
        {
            // 打开保存文件对话框
            SaveFileDialog saveFileDialog = new SaveFileDialog
            {
                Filter = "谱面文件 (*.json)|*.json|所有文件 (*.*)|*.*",
                Title = "保存谱面"
            };

            if (saveFileDialog.ShowDialog() == true)
            {
                // 保存谱面
                _scoreManager.Save(_currentScore, saveFileDialog.FileName);
                
                MessageBox.Show("谱面保存成功", "提示", MessageBoxButton.OK, MessageBoxImage.Information);
            }
        }

        private void LoadScoreButton_Click(object sender, RoutedEventArgs e)
        {
            // 打开文件选择对话框
            OpenFileDialog openFileDialog = new OpenFileDialog
            {
                Filter = "谱面文件 (*.json)|*.json|所有文件 (*.*)|*.*",
                Title = "选择谱面文件"
            };

            if (openFileDialog.ShowDialog() == true)
            {
                // 加载谱面
                _currentScore = _scoreManager.Load(openFileDialog.FileName);
                
                // 清空当前音符
                ClearNotes();
                
                // 绘制所有音符
                foreach (Note note in _currentScore.Notes)
                {
                    DrawNote(note);
                }
                
                // 如果有音乐文件，加载音乐
                if (!string.IsNullOrEmpty(_currentScore.MusicFilePath))
                {
                    _audioPlayer.Load(_currentScore.MusicFilePath);
                }
                
                MessageBox.Show("谱面加载成功", "提示", MessageBoxButton.OK, MessageBoxImage.Information);
            }
        }

        private void ClearAllButton_Click(object sender, RoutedEventArgs e)
        {
            // 清空所有音符
            if (MessageBox.Show("确定要清空所有音符吗？", "确认", MessageBoxButton.YesNo, MessageBoxImage.Question) == MessageBoxResult.Yes)
            {
                ClearNotes();
                _currentScore.Notes.Clear();
            }
        }

        /// <summary>
        /// 绘制音符
        /// </summary>
        /// <param name="note">音符数据</param>
        private void DrawNote(Note note)
        {
            // 创建音符图形
            Ellipse noteEllipse = new Ellipse
            {
                Width = 30,
                Height = 30,
                Fill = Brushes.Orange,
                Stroke = Brushes.Black,
                StrokeThickness = 2
            };

            // 计算音符位置
            // 水平位置基于时间，垂直位置基于轨道
            double x = note.Time * 100; // 简单映射，1秒=100像素
            double y = note.LineIndex * 100 + 50; // 每条轨道间隔100像素

            // 设置位置
            Canvas.SetLeft(noteEllipse, x);
            Canvas.SetTop(noteEllipse, y);

            // 添加到画布
            NotesCanvas.Children.Add(noteEllipse);
            _noteShapes.Add(noteEllipse);
        }

        /// <summary>
        /// 清空所有音符
        /// </summary>
        private void ClearNotes()
        {
            foreach (Ellipse noteShape in _noteShapes)
            {
                NotesCanvas.Children.Remove(noteShape);
            }
            _noteShapes.Clear();
        }
    }
}