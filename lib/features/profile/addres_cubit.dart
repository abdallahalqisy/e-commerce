import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'addres_state.dart';

class AddresCubit extends Cubit<AddresState> {
  AddresCubit() : super(AddresInitial());

  
}
