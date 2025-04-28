namespace EfCrud.Entities
{
    public class Category
    {
        public int Id { get; set; }
        public string Title { get; set; } = string.Empty;
        public string Slug { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public bool Active { get; set; } = true;

        public Category() { }

        public Category(int id, string title, string slug, string description)
        {
            Id = id;
            Title = title;
            Slug = slug;
            Description = description;
        }
    }
}
