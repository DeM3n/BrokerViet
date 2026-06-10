using BrokerViet.BackendDotnet.Models;
using brokerviet_dotnet.Dtos.Requests;
using brokerviet_dotnet.Services.Impl;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace brokerviet_dotnet.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProfileController : ControllerBase
    {
        private readonly ProfileServiceImpl _service;

        public ProfileController(ProfileServiceImpl service)
        {
            _service = service;
        }

        [HttpPost("register")]
        public async Task<IActionResult> Register([FromBody] RegisterRequestDto profile)
        {
            var result = await _service.Register(profile);
            if (result == null)
            {
                return BadRequest("Registration failed.");
            }
            return Ok(result);
        }

        [HttpGet("show-all-profiles")]
        public async Task<IActionResult> ShowAllProfiles()
        {
            var profiles = await _service.ShowAllProfiles();
            return Ok(profiles);
        }
    }
}
