import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/domain/models/post_model.dart';
@injectable
class GetPostsUseCase {
  GetPostsUseCase();

  Future<List<PostModel>> call() async {
    // Dummy data
    return [
      const PostModel(id: '1', title: 'Welcome', content: 'Welcome to WAT Project!'),
    ];
  }
}
