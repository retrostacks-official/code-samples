import 'package:bloc/bloc.dart';
import 'package:customer_zimkey/data/model/data_handling/state_model/state_model.dart';
import 'package:customer_zimkey/data/model/services/single_service_response.dart';
import 'package:equatable/equatable.dart';

import '../../../data/provider/services_provider.dart';

part 'services_event.dart';
part 'services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  final ServicesProvider servicesProvider;
  ServicesBloc({required this.servicesProvider}) : super(ServicesInitial()) {
    on<ServicesEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<LoadSingleService>((event,emit) async {
      emit(ServicesLoading());
      ResponseModel stateModel = await servicesProvider.fetchSingleService(event.id);
      if(stateModel is SuccessResponse){
        emit(SingleServiceLoaded(serviceResponse: stateModel.value));

      }else if(stateModel is ErrorResponse){

      }

    });
  }
}
