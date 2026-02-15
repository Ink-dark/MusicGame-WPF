using System.IO;
using System.Text.Json;
using MusicGame.Models;

namespace MusicGame.Services
{
    /// <summary>
    /// 谱面管理服务
    /// </summary>
    public class ScoreManager
    {
        private readonly JsonSerializerOptions _jsonOptions = new JsonSerializerOptions
        {
            WriteIndented = true,
            PropertyNamingPolicy = JsonNamingPolicy.CamelCase
        };

        /// <summary>
        /// 保存谱面
        /// </summary>
        /// <param name="score">谱面数据</param>
        /// <param name="filePath">保存路径</param>
        public void Save(Score score, string filePath)
        {
            string json = JsonSerializer.Serialize(score, _jsonOptions);
            File.WriteAllText(filePath, json);
        }

        /// <summary>
        /// 加载谱面
        /// </summary>
        /// <param name="filePath">文件路径</param>
        /// <returns>谱面数据</returns>
        public Score Load(string filePath)
        {
            string json = File.ReadAllText(filePath);
            return JsonSerializer.Deserialize<Score>(json, _jsonOptions) ?? new Score();
        }
    }
}