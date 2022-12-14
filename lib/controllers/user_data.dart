import 'dart:convert';

import 'package:codeforces_visualizer/models/problem.dart';
import 'package:codeforces_visualizer/models/rating_change.dart';
import 'package:codeforces_visualizer/models/submission.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/party.dart';
import '../models/user.dart';

class UserData with ChangeNotifier {
  static Future<List<User>> fetchUsers(List<String> userHandles) async {
    var url = 'https://codeforces.com/api/user.info?handles=';

    for (var i = 0; i < userHandles.length; i++) {
      url += '${userHandles[i]};';
    }

    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);

    List<User> usersdata = [];
    if (body['status'] == 'OK') {
      List result = body['result'];

      for (var i = 0; i < result.length; i++) {
        usersdata.add(User(
            handle: result[i]['handle'],
            email: '',
            contribution: result[i]['contribution'],
            rank: result[i]['rank'],
            rating: result[i]['rating'],
            maxRank: result[i]['maxRank'],
            maxRating: result[i]['maxRating'],
            lastOnlineTimeSeconds: result[i]['lastOnlineTimeSeconds'],
            registrationTimeSeconds: result[i]['registrationTimeSeconds'],
            avatar: result[i]['avatar'],
            titlePhoto: result[i]['titlephoto']));
      }
    } else {
      // handle error here
    }

    return usersdata;
  }

  static Future<List<Submission>> fetchUserSubmissions(
      String userHandle) async {
    // user.status method
    var url =
        'https://codeforces.com/api/user.status?handle=$userHandle&from=1&count=20';

    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);

    List<Submission> submissiondata = [];
    if (body['status'] == 'OK') {
      List result = body['result'] as List;

      //result[i]['problem']

      for (var i = 0; i < result.length; i++) {
        List membersresult = result[i]['author']['members'];
        List<Member> membersdata = [];

        for(var j = 0; j < membersresult.length; j++) {
          membersdata.add(Member(
              handle: membersresult[j]['handle'])
          );
        }

        submissiondata.add(Submission(
            id: result[i]['id'],
            contestId: result[i]['contestId'],
            creationTimeSeconds: result[i]['creationTimeSeconds'],
            problem: Problem(
                index: result[i]['problem']['index'],
                name: result[i]['problem']['name'],
                type: result[i]['problem']['type'],
                tags: result[i]['problem']['tags']),
            party: Party(
                contestId: result[i]['author']['contestId'],
                members: membersdata,
                participantType: result[i]['author']['participantType'],
                ghost: result[i]['author']['ghost'],
                startTimeSeconds: result[i]['author']['startTimeSeconds']),
            programmingLanguage: result[i]['programmingLanguage'],
            verdict: result[i]['verdict'],
            passedTestCount: result[i]['passedTestCount'],
            timeConsumedMillis: result[i]['timeConsumedMillis'],
            memoryConsumedBytes: result[i]['memoryConsumedBytes']));
      }
    } else {
      //handle error
    }


    return submissiondata;
  }

  static Future<List<RatingChange>> fetchRatingchanges(
      String userHandle) async {
    //user.rating
    var url = 'https://codeforces.com/api/user.rating?handle=$userHandle';

    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);

    List<RatingChange> ratingchangedata = [];
    if (body['status'] == 'OK') {
      List result = body['result'];

      for (var i = 0; i < result.length; i++) {
        ratingchangedata.add(RatingChange(
            contestId: result[i]['contestId'],
            contestName: result[i]['contestName'],
            handle: result[i]['handle'],
            rank: result[i]['rank'],
            ratingUpdateTimeSeconds: result[i]['ratingUpdateTimeSeconds'],
            oldRating: result[i]['oldRating'],
            newRating: result[i]['newRating']));
      }
    } else {
      //handle error
    }

    return ratingchangedata;
  }

  static Future<List<User>> fetchUsersOfContest(String contestId) async {
    //user.ratedList method
    var url =
        'https://codeforces.com/api/user.ratedList?activeOnly=true&includeRetired=false&contestId=$contestId';

    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);

    List<User> usersdata = [];
    if (body['status'] == 'OK') {
      List result = body['result'];

      for (var i = 0; i < result.length; i++) {
        usersdata.add(User(
            handle: result[i]['handle'],
            email: '',
            contribution: result[i]['contribution'],
            rank: result[i]['rank'],
            rating: result[i]['rating'],
            maxRank: result[i]['maxRank'],
            maxRating: result[i]['maxRating'],
            lastOnlineTimeSeconds: result[i]['lastOnlineTimeSeconds'],
            registrationTimeSeconds: result[i]['registrationTimeSeconds'],
            avatar: result[i]['avatar'],
            titlePhoto: result[i]['titlephoto']));
      }
    } else {
      // handle error here
    }

    return usersdata;
  }
}
