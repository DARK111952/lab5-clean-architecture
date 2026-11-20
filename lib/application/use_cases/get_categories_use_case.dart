import '../../domain/repositories/ad_repository.dart';

/// Use case «Отримати список категорій».
class GetCategoriesUseCase {
  const GetCategoriesUseCase(this._repository);

  final AdRepository _repository;

  List<String> call() => List.unmodifiable(_repository.getCategories());
}
