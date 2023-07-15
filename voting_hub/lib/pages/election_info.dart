import 'package:flutter/material.dart';
import 'package:voting_hub/services/functions.dart';
import 'package:web3dart/web3dart.dart';

class ElectionInfo extends StatefulWidget {
  final Web3Client ethClient;
  final String electionName;
  const ElectionInfo(
      {super.key, required this.ethClient, required this.electionName});

  @override
  State<ElectionInfo> createState() => _ElectionInfoState();
}

class _ElectionInfoState extends State<ElectionInfo> {
  TextEditingController addCandidateController = TextEditingController();
  TextEditingController authVoterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.electionName),
      ),
      body: Container(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    FutureBuilder<List>(
                        future: getCandidateNum(widget.ethClient),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          return Text(
                            snapshot.data![0].toString(),
                            style: const TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }),
                    const Text('Total Candidates')
                  ],
                ),
                Column(
                  children: [
                    FutureBuilder<List>(
                        future: getTotalVotes(widget.ethClient),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          return Text(
                            snapshot.data![0].toString(),
                            style: const TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }),
                    const Text('Total Votes'),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: addCandidateController,
                    decoration:
                        const InputDecoration(hintText: 'Enter Candidate Name'),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      addCandidate(
                          addCandidateController.text, widget.ethClient);
                    },
                    child: const Text('Add Candidate'))
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: authVoterController,
                    decoration:
                        const InputDecoration(hintText: 'Enter Voter Address'),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      authVoter(authVoterController.text, widget.ethClient);
                    },
                    child: const Text('Add Voter'))
              ],
            ),
            const Divider(),
            FutureBuilder<List>(
                future: getCandidateNum(widget.ethClient),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else {
                    return Column(
                      children: [
                        for (int i = 0; i < snapshot.data![0].toInt(); i++)
                          FutureBuilder(
                              future: getCandidateInfo(i, widget.ethClient),
                              builder: (context, candidateSnapshot) {
                                if (candidateSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else {
                                  return ListTile(
                                    title: Text(
                                        'Name : ${candidateSnapshot.data![0][0].toString()}'),
                                    subtitle: Text(
                                        'Votes : ${candidateSnapshot.data![0][1].toString()}'),
                                    trailing: ElevatedButton(
                                      onPressed: () {
                                        vote(i, widget.ethClient);

                                      },
                                      child: const Text('Vote'),
                                    ),
                                  );
                                }
                              })
                      ],
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
