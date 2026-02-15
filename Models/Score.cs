namespace MusicGame.Models
{
    /// <summary>
    /// 谱面模型
    /// </summary>
    public class Score
    {
        /// <summary>
        /// 谱面名称
        /// </summary>
        public string Name { get; set; } = "Untitled";

        /// <summary>
        /// 音乐文件路径
        /// </summary>
        public string MusicFilePath { get; set; } = string.Empty;

        /// <summary>
        /// 音符列表
        /// </summary>
        public List<Note> Notes { get; set; } = new List<Note>();

        /// <summary>
        /// BPM（每分钟节拍数）
        /// </summary>
        public double Bpm { get; set; } = 120;
    }
}