import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:fpdart/fpdart.dart';
import 'package:organization_managing_app/core/error/failure.dart';
import 'package:organization_managing_app/core/error/server_exception.dart';
import 'package:organization_managing_app/core/internet/internet_connection_service.dart';
import 'package:organization_managing_app/core/locator/locator.dart';
import 'package:organization_managing_app/core/utils/appwrite_constants.dart';
import 'package:organization_managing_app/data/appwrite_provider.dart';
import 'package:organization_managing_app/data/model/member_model.dart';

class MembersRepository {
  final AppwriteProvider _appwriteProvider = locator<AppwriteProvider>();
  final InternetConnectionService _internetConnectionService =
      locator<InternetConnectionService>();

  Future<Either<Failure, Document>> addMember({
    required String firstName,
    required String lastName,
    String? email,
    DateTime? birthDate,
    DateTime? entryDate,
  }) async {
    try {
      if (await _internetConnectionService.hasInternetAccess()) {
        final uniqueId = ID.unique();
        Document document = await _appwriteProvider.database!.createDocument(
          databaseId: AppwriteConstants.databaseId,
          collectionId: AppwriteConstants.membersCollectionId,
          documentId: uniqueId,
          data: {
            "id": uniqueId,
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "birthDate": birthDate,
            "entryDate": entryDate,
          },
        );
        return right(document);
      } else {
        return left(Failure(
          message: "", // Message will be translated
          type: FailureType.internet,
        ));
      }
    } on AppwriteException catch (e) {
      return left(Failure(
        message: e.message!,
        type: FailureType.appwrite,
      ));
    } on ServerException catch (e) {
      return left(Failure(
        message: e.message,
        type: FailureType.internal,
      ));
    }
  }

  Future<Either<Failure, List<MemberModel>>> getAllMembers() async {
    try {
      if (await _internetConnectionService.hasInternetAccess()) {
        DocumentList documents = await _appwriteProvider.database!.listDocuments(
          databaseId: AppwriteConstants.databaseId,
          collectionId: AppwriteConstants.membersCollectionId,
        );
        Map<String, dynamic> data = documents.toMap();
        List d = data['documents'].toList();
        List<MemberModel> memberList =
            d.map((e) => MemberModel.fromMap(e['data'])).toList();
        return right(memberList);
      } else {
        return left(Failure(
          message: "", // Message will be translated
          type: FailureType.internet,
        ));
      }
    } on AppwriteException catch (e) {
      return left(Failure(
        message: e.message!,
        type: FailureType.appwrite,
      ));
    } on ServerException catch (e) {
      return left(Failure(
        message: e.message,
        type: FailureType.internal,
      ));
    }
  }
}