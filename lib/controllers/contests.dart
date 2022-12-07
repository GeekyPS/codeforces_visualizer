import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/contest.dart';
import '../models/party.dart';
import '../models/problem.dart';
import '../models/problem_result.dart';
import '../models/rank_list_row.dart';
import '../models/rating_change.dart';
import '../models/standing_return_object.dart';
import '../models/submission.dart';

class contestData with ChangeNotifier {
  // handle all contest methods

  static Future<List<RatingChange>> fetchContestRatingChanges(
      String contestId) async {
    //contest.ratingChanges
    var url = 'https://codeforces.com/api/contest.ratingChanges?contestId=$contestId';

    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);

    List<RatingChange> ratingchangedata = [];
    if (body['status'] == 'OK') {
      List result = body['result'];

      for (var i = 0; i < result.length; i++) {
        ratingchangedata.add(RatingChange(
            contestId: result[i]['contestID'],
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
    print(ratingchangedata.length);

    return ratingchangedata;
  }

  static Future<List<Contest>> fetchContestList(
      String contestId) async {
    //contest.ratingChanges
    var url = 'https://codeforces.com/api/contest.list?gym=false';

    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);

    List<Contest> contestdata = [];
    if (body['status'] == 'OK') {
      List result = body['result'];

      for (var i = 0; i < result.length; i++) {
        contestdata.add(Contest(
            id: result[i]['id'],
            name: result[i]['name'],
            type: result[i]['type'],
            phase: result[i]['phase'],
            frozen: result[i]['frozen'],
            durationSeconds: result[i]['durationSeconds'])
        );
      }
    } else {
      //handle error
    }
    print(contestdata.length);

    return contestdata;
  }

  static Future<StandingReturnObject> fetchContestStandings(
      String contestId) async {
    //contest.standings
    var url = 'https://codeforces.com/api/contest.standings?contestId=$contestId&from=1&count=5&showUnofficial=true';

    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);

    StandingReturnObject returndata = StandingReturnObject(
        contest: Contest(
            id: 0,
            name: '',
            type: '',
            phase: '',
            frozen: false,
            durationSeconds: 0),
        problems: [],
        rows: []
    );

    if (body['status'] == 'OK') {

      Contest contestdata = Contest(
          id: body['result']['contest']['id'],
          name: body['result']['contest']['name'],
          type: body['result']['contest']['type'],
          phase: body['result']['contest']['phase'],
          frozen: body['result']['contest']['frozen'],
          durationSeconds: body['result']['contest']['durationSeconds']
      );

      List problemresult = body['result']['problems'];
      List<Problem> problemdata = [];
      for (var i = 0; i < problemresult.length; i++) {
        List<dynamic> tagslist = [];
        for(var j = 0; j < problemresult[i]['tags'].length(); j++) {
          tagslist.add(problemresult[i]['contestId'][j]);
        }

        problemdata.add(Problem(
            contestId: problemresult[i]['contestId'],
            index: problemresult[i]['index'],
            name: problemresult[i]['name'],
            type: problemresult[i]['type'],
            rating: problemresult[i]['rating'],
            tags: tagslist)
        );
      }

      List rowsresult = body['result']['rows'];
      List<RanklistRow> rowsdata = [];
      for(var i = 0; i < rowsresult.length; i++) {
        List problemresultsresult = rowsresult[i]['problemResults'];
        List<ProblemResult> problemresultsdata = [];

        for(var j = 0; j < problemresultsresult.length; j++) {
          problemresultsdata.add(ProblemResult(
              points: problemresultsresult[j]['points'],
              rejectedAttemptCount: problemresultsresult[j]['rejectedAttemptCount'],
              type: problemresultsresult[j]['type'],
              bestSubmissionTimeSeconds: problemresultsresult[j]['bestSubmissionTimeSeconds'])
          );
        }

        List membersresult = rowsresult[i]['party']['members'];
        List<Member> membersdata = [];

        for(var j = 0; j < membersresult.length; j++) {
          membersdata.add(Member(
              handle: membersresult[j]['handle'])
          );
        }

        rowsdata.add(RanklistRow(
            party: Party(
              contestId: rowsresult[i]['party']['contestId'],
              members: membersdata,
              participantType: rowsresult[i]['party']['participantType'],
              ghost: rowsresult[i]['party']['ghost'],
              startTimeSeconds: rowsresult[i]['party']['startTimeSeconds']),
            rank: rowsresult[i]['rank'],
            points: rowsresult[i]['points'],
            penalty: rowsresult[i]['penalty'],
            successfulHackCount: rowsresult[i]['successfulHackCount'],
            unsuccessfulHackCount: rowsresult[i]['unsuccessfulHackCount'],
            problemResults: problemresultsdata)
        );
      }

      returndata = StandingReturnObject(
          contest: contestdata,
          problems: problemdata,
          rows: rowsdata
      );
    } else {
      //handle error
    }

    return returndata;
  }

  static Future<List<Submission>> fetchContestSubmissions(
      String contestId) async {
    // contest.status method
    var url =
        'https://codeforces.com/api/contest.status?contestId=$contestId&from=1&count=10';

    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);

    List<Submission> submissiondata = [];
    if (body['status'] == 'OK') {
      List result = body['result'];

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
    print(submissiondata[0].contestId);

    return submissiondata;
  }
}