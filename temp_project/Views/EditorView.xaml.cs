using System.Windows.Controls;

namespace MusicGame.Views
{
    /// <summary>
    /// EditorView.xaml 的交互逻辑
    /// </summary>
    public partial class EditorView : UserControl
    {
        public EditorView()
        {
            InitializeComponent();
            InitializeLineComboBox();
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

        private void AddNoteButton_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            // TODO: 实现添加音符逻辑
        }

        private void DeleteNoteButton_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            // TODO: 实现删除音符逻辑
        }

        private void LoadMusicButton_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            // TODO: 实现加载音乐逻辑
        }

        private void PlayMusicButton_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            // TODO: 实现播放音乐逻辑
        }

        private void PauseMusicButton_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            // TODO: 实现暂停音乐逻辑
        }

        private void SaveScoreButton_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            // TODO: 实现保存谱面逻辑
        }

        private void LoadScoreButton_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            // TODO: 实现加载谱面逻辑
        }

        private void ClearAllButton_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            // TODO: 实现清空所有音符逻辑
        }
    }
}