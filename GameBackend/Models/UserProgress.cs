using Supabase.Postgrest.Attributes;
using Supabase.Postgrest.Models;

namespace GameBackend.Models
{
    [Table("user_progress")]
    public class UserProgress : BaseModel
    {
        [PrimaryKey("id", false)]
        public int Id { get; set; }

        [Column("username")]
        public required string Username { get; set; }

        [Column("password_hash")]
        public required string PasswordHash { get; set; }

        [Column("total_score")]
        public int TotalScore { get; set; }

        [Column("last_completed_level")]
        public int LastCompletedLevel { get; set; }
    }
}

