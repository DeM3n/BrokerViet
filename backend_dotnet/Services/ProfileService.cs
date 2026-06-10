using BrokerViet.BackendDotnet.Models;
using brokerviet_dotnet.Dtos.Requests;

namespace brokerviet_dotnet.Services
{
    public interface ProfileService
    {
        Task<Profile?> Register(RegisterRequestDto profile);
        Task<List<Profile>> ShowAllProfiles();
    }
}
