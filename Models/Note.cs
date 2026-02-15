namespace MusicGame.Models
{
    /// <summary>
    /// 音符模型
    /// </summary>
    public class Note
    {
        /// <summary>
        /// 轨道索引（0-5）
        /// </summary>
        public int LineIndex { get; set; }

        /// <summary>
        /// 出现时间（秒）
        /// </summary>
        public double Time { get; set; }

        /// <summary>
        /// 音符时长（秒）
        /// </summary>
        public double Duration { get; set; }
    }
}