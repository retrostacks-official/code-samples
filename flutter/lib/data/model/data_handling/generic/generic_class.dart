
import '../../address/add_address_response.dart';
import '../../address/address_list_response.dart';
import '../../address/delete_address_response.dart';
import '../../address/update_address_response.dart';
import '../../booking_slot/booking_slots_response.dart';
import '../../bookings/booking_list_response.dart';
import '../../checkout/booking_created_response.dart';
import '../../checkout/checkout_summary_response.dart';
import '../../checkout/update_payment/payment_updated_response.dart';
import '../../services/single_service_response.dart';

class Generic {
  /// If T is a List, K is the subtype of the list.
  static T fromJson<T>(dynamic data) {
    if (T == SingleServiceResponse) {
      return SingleServiceResponse.fromJson(data) as T;
    } else if (T == AddressListResponse) {
      return AddressListResponse.fromJson(data) as T;
    } else if (T == AddAddressResponse) {
      return AddAddressResponse.fromJson(data) as T;
    } else if (T == UpdateAddressResponse) {
      return UpdateAddressResponse.fromJson(data) as T;
    } else if (T == DeleteAddressResponse) {
      return DeleteAddressResponse.fromJson(data) as T;
    }  else if (T == BookingSlotsResponse) {
      return BookingSlotsResponse.fromJson(data) as T;
    } else if (T == CheckoutSummaryResponse) {
      return CheckoutSummaryResponse.fromJson(data) as T;
    } else if (T == BookingCreatedResponse) {
      return BookingCreatedResponse.fromJson(data) as T;
    } else if (T == PaymentUpdatedResponse) {
      return PaymentUpdatedResponse.fromJson(data) as T;
    } else if (T == BookingListResponse) {
      return BookingListResponse.fromJson(data) as T;
    }else if (T == bool || T == String || T == int || T == double) {
      // primitives
      return data;
    } else {
      throw Exception("Unknown class");
    }
  }
}
