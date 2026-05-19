import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:medrep_pro/core/constants/supabase_constants.dart';
import 'package:medrep_pro/core/error/exceptions.dart';
import 'package:medrep_pro/features/dcr/data/models/dcr_dto.dart';
import 'package:medrep_pro/features/dcr/data/models/dcr_doctor_visit_dto.dart';
import 'package:medrep_pro/features/dcr/data/models/dcr_chemist_visit_dto.dart';

class DcrRemoteDataSource {
  final SupabaseClient _supabase;

  DcrRemoteDataSource(this._supabase);

  Future<List<DcrDto>> getDcrsByRep(String repId) async {
    try {
      final response = await _supabase
          .from(SupabaseConstants.dcrsTable)
          .select()
          .eq('rep_id', repId)
          .order('date', ascending: false);

      return (response as List).map((json) => DcrDto.fromJson(json)).toList();
    } catch (e) {
      throw ServerException(message: 'Failed to fetch DCRs: $e');
    }
  }

  Future<void> upsertDcr(DcrDto dcr) async {
    try {
      await _supabase.from(SupabaseConstants.dcrsTable).upsert(dcr.toJson());
    } catch (e) {
      throw ServerException(message: 'Failed to sync DCR: $e');
    }
  }

  Future<List<DcrDoctorVisitDto>> getDoctorVisits(String dcrId) async {
    try {
      final response = await _supabase
          .from(SupabaseConstants.dcrDoctorVisitsTable)
          .select()
          .eq('dcr_id', dcrId);

      return (response as List).map((json) => DcrDoctorVisitDto.fromJson(json)).toList();
    } catch (e) {
      throw ServerException(message: 'Failed to fetch doctor visits: $e');
    }
  }

  Future<void> upsertDoctorVisits(List<DcrDoctorVisitDto> visits) async {
    if (visits.isEmpty) return;
    try {
      await _supabase.from(SupabaseConstants.dcrDoctorVisitsTable).upsert(visits.map((v) => v.toJson()).toList());
    } catch (e) {
      throw ServerException(message: 'Failed to sync doctor visits: $e');
    }
  }

  Future<List<DcrChemistVisitDto>> getChemistVisits(String dcrId) async {
    try {
      final response = await _supabase
          .from(SupabaseConstants.dcrChemistVisitsTable)
          .select()
          .eq('dcr_id', dcrId);

      return (response as List).map((json) => DcrChemistVisitDto.fromJson(json)).toList();
    } catch (e) {
      throw ServerException(message: 'Failed to fetch chemist visits: $e');
    }
  }

  Future<void> upsertChemistVisits(List<DcrChemistVisitDto> visits) async {
    if (visits.isEmpty) return;
    try {
      await _supabase.from(SupabaseConstants.dcrChemistVisitsTable).upsert(visits.map((v) => v.toJson()).toList());
    } catch (e) {
      throw ServerException(message: 'Failed to sync chemist visits: $e');
    }
  }
}
