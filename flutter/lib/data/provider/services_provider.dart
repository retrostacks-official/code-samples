import '../../utils/helper/helper_functions.dart';
import '../../utils/object_factory.dart';
import '../model/data_handling/state_model/state_model.dart';
import '../model/services/single_service_response.dart';

class ServicesProvider{

  Future<ResponseModel> fetchSingleService(id) async {
    final response = await ObjectFactory().apiClient.fetchSingleService(id);
    return HelperFunctions.handleResponse<SingleServiceResponse>(response);
  }
}