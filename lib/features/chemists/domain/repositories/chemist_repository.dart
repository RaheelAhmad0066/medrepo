import 'package:medrep_pro/core/network/api_result.dart';
import 'package:medrep_pro/features/chemists/domain/entities/chemist.dart';

abstract class ChemistRepository {
  Future<ApiResult<List<Chemist>>> getChemists({
    int page = 1,
    int limit = 20,
    String? searchQuery,
    String? priorityTag,
    bool forceRefresh = false,
  });

  Future<ApiResult<Chemist>> addChemist(Chemist chemist);

  Future<ApiResult<Chemist>> updateChemist(Chemist chemist);

  Future<ApiResult<void>> deleteChemist(String chemistId);
}
