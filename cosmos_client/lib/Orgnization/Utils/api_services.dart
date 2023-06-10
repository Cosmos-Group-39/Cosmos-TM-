import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:8080/api/common/organization';

  //create an organization(form)
  Future<void> createOrganization({
    required String name,
    // required String pic,
    required String description,
  }) async {
    final url = Uri.parse('$baseUrl');
    final x = {
      'name': name,
      // 'pic': pic,
      'description': description,
    };

    print({x: jsonEncode(x)});
    var headers = {'Content-Type': 'application/json'};
// Make the POST request var response = await http.post(url, headers: headers, body: body);
    try {
      final response =
          await http.post(url, headers: headers, body: jsonEncode(x));
      if (response.statusCode == 200) {
        // Organization created successfully
        final responseData = jsonDecode(response.body);
        print(responseData);
        // Handle the response data as needed
      } else {
        // Error handling for failed request
        final errorData = jsonDecode(response.body);
        print(errorData);
        // Handle the error data as needed
      }
    } catch (e) {
      // Error handling for network or API call exception
      print('Exception occurred: $e');
    }
  }

  // //edit an organization(form)
  // Future<void> editOrganization({
  //   required String organizationId,
  //   required String name,
  //   required String pic,
  //   required String description,
  // }) async {
  //   final url = Uri.parse('$baseUrl/organizations/$organizationId');
  //   final body = {
  //     'name': name,
  //     'pic': pic,
  //     'description': description,
  //   };

  //   try {
  //     final response = await http.put(url, body: jsonEncode(body));
  //     if (response.statusCode == 200) {
  //       // Organization edited successfully
  //     } else {
  //       // Error handling for failed request
  //     }
  //   } catch (e) {
  //     // Error handling for network or API call exception
  //   }
  // }

  // Future<void> deleteOrganization(String organizationId) async {
  //   final url = Uri.parse('$baseUrl/organizations/$organizationId');

  //   try {
  //     final response = await http.delete(url);
  //     if (response.statusCode == 200) {
  //       // Organization deleted successfully
  //     } else {
  //       // Error handling for failed request
  //     }
  //   } catch (e) {
  //     // Error handling for network or API call exception
  //   }
  // }

  // Future<void> addMemberToOrganization({
  //   required String organizationId,
  //   required String memberId,
  // }) async {
  //   final url = Uri.parse('$baseUrl/organizations/$organizationId/members');
  //   final body = {'memberId': memberId};

  //   try {
  //     final response = await http.post(url, body: jsonEncode(body));
  //     if (response.statusCode == 200) {
  //       // Member added to the organization successfully
  //     } else {
  //       // Error handling for failed request
  //     }
  //   } catch (e) {
  //     // Error handling for network or API call exception
  //   }
  // }

  // Future<void> removeMemberFromOrganization({
  //   required String organizationId,
  //   required String memberId,
  // }) async {
  //   final url =
  //       Uri.parse('$baseUrl/organizations/$organizationId/members/$memberId');

  //   try {
  //     final response = await http.delete(url);
  //     if (response.statusCode == 200) {
  //       // Member removed from the organization successfully
  //     } else {
  //       // Error handling for failed request
  //     }
  //   } catch (e) {
  //     // Error handling for network or API call exception
  //   }
  // }
}
