class Mutations {
  Mutations._();

  static String sendOtp = """
     mutation sendOtp(\$phoneNumber: String!){
     sendOtp (data: {phoneNumber: \$phoneNumber}) {
     status
     message    
  }
}
  """
      .replaceAll('\n', '');

  static String verifyOtp = """
mutation verifyOtp(\$phoneNumber: String!,\$otp:String!){
  verifyOtp (data: {phoneNumber: \$phoneNumber,otp:\$otp}) {
    status
    message
    data{
      isCustomerRegistered
      token
      user{
      id
      name
      phone
      email
      }
    }    
  }
}
  """
      .replaceAll('\n', '');

  static String registerUser = """
mutation registerUser(\$data:UserRegisterGqlInput!){
  registerUser(data:\$data){
    id
    name
    phone  
    email
  }
}
  """
      .replaceAll('\n', '');

  static String updateUser = """
mutation UpdateUser(\$name:String!,\$email:String!) {
    updateUser(data: {name: \$name, email: \$email}) {
        name
        email
        phone
        id
    }
}
  """
      .replaceAll('\n', '');

  static String addCustomerSupport = '''
mutation AddCustomerSupport(\$subject:String!,\$message:String!) {
    addCustomerSupport(data: {subject: \$subject, message: \$message}) {
        id
        userId
        subject
        message
        createDateTime
    }
}
 '''
      .replaceAll('\n', '');

  static String addAddress = """
mutation addAddress(\$buildingName:String!,\$locality:String!,\$landmark:String!,\$areaId:String!,\$postalCode:String!,\$addressType:EnumAddressType!,\$otherText:String,\$isDefault:Boolean,
){
  addCustomerAddress(
    data: {
      buildingName: \$buildingName,
      locality: \$locality,
      landmark: \$landmark,
      areaId: \$areaId,
      postalCode: \$postalCode,
      addressType:\$addressType,
      otherText: \$otherText,
      isDefault: \$isDefault,
    }
  ) {
    customerAddresses {
      id
      buildingName
      locality
      landmark
      areaId
      area {
        id
        name
      }
      postalCode
      addressType
      otherText
      isDefault
    }
  }
}
  """
      .replaceAll('\n', '');

  static String updateAddress = """
mutation UpdateCustomerAddress(\$addressId:String!,\$buildingName:String!,\$locality:String!,\$landmark:String!,\$areaId:String!,\$postalCode:String!,\$addressType:EnumAddressType!,\$otherText:String,\$isDefault:Boolean,
){
  updateCustomerAddress(
  id: \$addressId,
    data: {
      buildingName: \$buildingName,
      locality: \$locality,
      landmark: \$landmark,
      areaId: \$areaId,
      postalCode: \$postalCode,
      addressType:\$addressType,
      otherText: \$otherText,
      isDefault: \$isDefault,
    }
  ) {
    customerAddresses {
      id
      buildingName
      locality
      landmark
      areaId
      area {
        id
        name
      }
      postalCode
      addressType
      otherText
      isDefault
    }
  }
}
  """
      .replaceAll('\n', '');

  static String deleteAddress = """
mutation deleteAddress(\$id:String!) {
  deleteCustomerAddress(addressId: \$id) {
    customerAddresses {
      id
      buildingName
      locality
      landmark
      areaId
      area {
        id
        name
      }
      postalCode
      addressType
      isDefault
      otherText
    }
  }
}
  """
      .replaceAll('\n', '');

  static String addReview = """
mutation AddReview(\$type:  ReviewTypeEnum!,\$bookingServiceItemId:String!,\$rating:Float!,\$review:String) {
    addReview(
        data: {type: \$type, bookingServiceItemId: \$bookingServiceItemId, rating: \$rating, review: \$review}
    ) {
        id
        rating
        review
    }
}
  """
      .replaceAll('\n', '');


  ///checkout provider
 static String createBooking = """
mutation CreateBooking(\$data: BookingGqlInput!) {
    createBooking(data: \$data) {
        id
        userBookingNumber
        bookingStatus
        bookingDate
        userId
        bookingNote
        appliedCoupons
        createDateTime
        bookingAmount {
            grandTotal
        }
        bookingPayments {
            id 
            orderId
           }
        bookingService {
            service {
                name
            }
        }
    }
}

  """
      .replaceAll('\n', '');


 static String updatePayment = """
mutation confirmPayment(\$data:PaymentConfirmGqlInput!){
confirmPayment(data:\$data) {
        paymentSuccess
        booking {
            id
            userBookingNumber
            bookingStatus
            bookingService {
                unit
                service {
                    id
                    name
                }
                serviceRequirements
                bookingServiceItems {
                    startDateTime
                    endDateTime
                    bookingServiceItemStatus
                    bookingServiceItemType
                    id
                }
            }
            bookingAddress {
                buildingName
                postalCode
                areaId
                locality
                addressType
                landmark
                area {
                    name
                    code
                    pinCodes {
                        pinCode
                    }
                    city {
                        name
                    }
                }
                otherText
                alternatePhoneNumber
            }
            bookingAmount {
                unitPrice
                partnerRate
                partnerDiscount
                partnerAmount
                subTotal
                totalDiscount
                totalAmount
                totalGSTAmount
                grandTotal
            }
            bookingPayments {
                id
                orderId
                paymentId
                amount
                amountPaid
                amountDue
                currency
                status
                attempts
                invoiceNumber
                bookingId
            }
            bookingDate
            pendingAmount {
                amount
                pendingFor {
                    serviceItems
                    addons
                    additionPayments
                    otherPayments
                }
            }
            bookingNote
            user {
                email
                isActive
                os
                os_version
            }
        }
        zpointsEarned
        popularServices {
      id
      name
      medias {
        type
        thumbnail {
          name
        }
        id
        url
        enabled
      }
    }
    }
}
  """
      .replaceAll('\n', '');







}
