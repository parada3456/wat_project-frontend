import os
import sys
import unittest

# Ensure the parent directory is in the path so we can import the script
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from extract_api_entities import parse_api_file, extract_clean_entity

class TestApiEntityExtractor(unittest.TestCase):
    def test_extract_clean_entity(self):
        # Basic types
        self.assertEqual(extract_clean_entity("void"), "void")
        self.assertEqual(extract_clean_entity("LoginEntity"), "LoginEntity")
        
        # PaginationResponse wrappers
        self.assertEqual(extract_clean_entity("PaginationResponse<UserBadgeEntity>"), "UserBadgeEntity")
        self.assertEqual(extract_clean_entity("PaginationResponse<JobPostingEntity>"), "JobPostingEntity")
        
        # List wrappers
        self.assertEqual(extract_clean_entity("List<UserAccountEntity>"), "UserAccountEntity")
        
        # Map/Dynamic types (should return unchanged or cleaned slightly)
        self.assertEqual(extract_clean_entity("Map<String, dynamic>"), "Map<String, dynamic>")
        
        # Nested custom wrapper types (recursively unwrapped if we match them)
        self.assertEqual(extract_clean_entity("List<PaginationResponse<BadgeEntity>>"), "BadgeEntity")

    def test_parse_api_file_simple(self):
        content = """
        import 'package:retrofit/retrofit.dart';
        
        @RestApi()
        abstract class AuthApiService {
          @POST('auth/login')
          Future<LoginEntity> login(@Body() LoginRequest request);
          
          @GET('users/me')
          Future<UserProfileEntity> getProfile();
          
          @DELETE('users/me')
          Future<void> deleteAccount();
        }
        """
        results = parse_api_file(content)
        self.assertEqual(len(results), 3)
        
        # Check login
        self.assertEqual(results[0]["service"], "AuthApiService")
        self.assertEqual(results[0]["method"], "login")
        self.assertEqual(results[0]["http_method"], "POST")
        self.assertEqual(results[0]["route"], "auth/login")
        self.assertEqual(results[0]["return_type"], "Future<LoginEntity>")
        self.assertEqual(results[0]["entity"], "LoginEntity")

        # Check deleteAccount
        self.assertEqual(results[2]["method"], "deleteAccount")
        self.assertEqual(results[2]["http_method"], "DELETE")
        self.assertEqual(results[2]["route"], "users/me")
        self.assertEqual(results[2]["return_type"], "Future<void>")
        self.assertEqual(results[2]["entity"], "void")

    def test_parse_api_file_nested_and_multiline(self):
        content = """
        @RestApi()
        abstract class JobApiService {
          @GET('user/badges')
          Future<PaginationResponse<UserBadgeEntity>> getBadges();

          @POST('media/upload')
          @MultiPart()
          Future<UploadMediaResponse> uploadMedia(
            @Part(name: 'file') File file, {
            @Part(name: 'bucket') String? bucket,
          });
        }
        """
        results = parse_api_file(content)
        self.assertEqual(len(results), 2)
        
        # Check getBadges
        self.assertEqual(results[0]["method"], "getBadges")
        self.assertEqual(results[0]["http_method"], "GET")
        self.assertEqual(results[0]["route"], "user/badges")
        self.assertEqual(results[0]["return_type"], "Future<PaginationResponse<UserBadgeEntity>>")
        self.assertEqual(results[0]["entity"], "UserBadgeEntity")
        
        # Check uploadMedia
        self.assertEqual(results[1]["method"], "uploadMedia")
        self.assertEqual(results[1]["http_method"], "POST")
        self.assertEqual(results[1]["route"], "media/upload")
        self.assertEqual(results[1]["return_type"], "Future<UploadMediaResponse>")
        self.assertEqual(results[1]["entity"], "UploadMediaResponse")

    def test_parse_api_file_extra_annotations_and_comments(self):
        content = """
        @RestApi()
        abstract class ExtraService {
          // This is a comment before the endpoint
          @POST('auth/refresh')
          @Extra({'needLogin': false})
          Future<AuthEntity> refresh(@Body() AuthRefreshRequest request);
          
          /*
           * Multi-line comment
           */
          @POST('auth/logout')
          Future<void> logout();
        }
        """
        results = parse_api_file(content)
        self.assertEqual(len(results), 2)
        
        self.assertEqual(results[0]["method"], "refresh")
        self.assertEqual(results[0]["entity"], "AuthEntity")
        self.assertEqual(results[1]["method"], "logout")
        self.assertEqual(results[1]["entity"], "void")

if __name__ == "__main__":
    unittest.main()
