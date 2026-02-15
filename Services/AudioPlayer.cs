using NAudio.Wave;

namespace MusicGame.Services
{
    /// <summary>
    /// 音频播放器服务
    /// </summary>
    public class AudioPlayer : IDisposable
    {
        private WaveOutEvent? _outputDevice;
        private AudioFileReader? _audioFile;
        private bool _isDisposed;

        /// <summary>
        /// 播放状态
        /// </summary>
        public bool IsPlaying => _outputDevice?.PlaybackState == PlaybackState.Playing;

        /// <summary>
        /// 当前播放位置（秒）
        /// </summary>
        public double CurrentTime => _audioFile?.CurrentTime.TotalSeconds ?? 0;

        /// <summary>
        /// 音乐总时长（秒）
        /// </summary>
        public double TotalTime => _audioFile?.TotalTime.TotalSeconds ?? 0;

        /// <summary>
        /// 加载音乐文件
        /// </summary>
        /// <param name="filePath">文件路径</param>
        public void Load(string filePath)
        {
            // 释放之前的资源
            DisposeAudio();

            // 创建新的音频文件阅读器
            _audioFile = new AudioFileReader(filePath);
            _outputDevice = new WaveOutEvent();
            _outputDevice.Init(_audioFile);
        }

        /// <summary>
        /// 播放音乐
        /// </summary>
        public void Play()
        {
            if (_outputDevice?.PlaybackState == PlaybackState.Paused)
            {
                _outputDevice.Play();
            }
        }

        /// <summary>
        /// 暂停音乐
        /// </summary>
        public void Pause()
        {
            if (_outputDevice?.PlaybackState == PlaybackState.Playing)
            {
                _outputDevice.Pause();
            }
        }

        /// <summary>
        /// 停止音乐
        /// </summary>
        public void Stop()
        {
            _outputDevice?.Stop();
            _audioFile?.Seek(0, System.IO.SeekOrigin.Begin);
        }

        /// <summary>
        /// 释放音频资源
        /// </summary>
        private void DisposeAudio()
        {
            _outputDevice?.Stop();
            _outputDevice?.Dispose();
            _audioFile?.Dispose();
            _outputDevice = null;
            _audioFile = null;
        }

        /// <summary>
        /// 释放资源
        /// </summary>
        public void Dispose()
        {
            if (!_isDisposed)
            {
                DisposeAudio();
                _isDisposed = true;
            }
        }
    }
}