using BrokerViet.BackendDotnet.Models;
using BrokerViet.BackendDotnet.Repositories;
using brokerviet_dotnet.Dtos.Requests;

namespace brokerviet_dotnet.Services.Impl
{
    public class ProfileServiceImpl : ProfileService
    {
        private readonly ProfileRepository _repo;

        public ProfileServiceImpl(ProfileRepository repo)
        {
            _repo = repo;
        }

        public async Task<Profile?> Register(RegisterRequestDto profile)
        {
            var newProfile = new Profile
            {
                UserId = Guid.NewGuid(),
                Username = profile.Username,
                Password = profile.Password,
                PhoneNumber = profile.PhoneNumber
            };

            var result = await _repo.InsertAsync(newProfile);
            return result.FirstOrDefault();
        }

        public async Task<List<Profile>> ShowAllProfiles()
        {
            var profiles = await _repo.GetAllAsync();
            return profiles.ToList();
        }
    }
}
