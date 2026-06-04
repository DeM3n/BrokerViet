namespace brokerviet_dotnet.Dtos.Requests
{
    public class RegisterRequestDto
    {
        public required string Username { get; set; }
        public required string Password { get; set; }
        public required string PhoneNumber { get; set; }

    }
}
