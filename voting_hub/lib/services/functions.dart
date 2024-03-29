import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:voting_hub/utils/constants.dart';
import 'package:web3dart/web3dart.dart';

Future<DeployedContract> loadContract() async {
  String abi = await rootBundle.loadString('assets/abi.json');
  String contractAddress = contract_address;

  final contract = DeployedContract(ContractAbi.fromJson(abi, 'Election'),
      EthereumAddress.fromHex(contractAddress));

  return contract;
}

Future<String> callFunction(String funcName, List<dynamic> args,
    Web3Client ethClient, String privateKey) async {
  EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);

  DeployedContract contract = await loadContract();
  final ethFunction = contract.function(funcName);
  final result = await ethClient.sendTransaction(
      credentials,
      Transaction.callContract(
          contract: contract, function: ethFunction, parameters: args),
      chainId: null,
      fetchChainIdFromNetworkId: true);

  return result;
}

Future<String> startElection(String name, Web3Client ethClient) async {
  var response =
      await callFunction('startElection', [name], ethClient, owner_private_key);

  if (kDebugMode) {
    print('Election started successfully');
  }
  return response;
}

Future<String> addCandidate(String name, Web3Client ethClient) async {
  var response =
      await callFunction('addCandidate', [name], ethClient, owner_private_key);

  if (kDebugMode) {
    print('Candidate added successfully');
  }
  return response;
}

Future<String> authVoter(String address, Web3Client ethClient) async {
  var response = await callFunction('authVoter',
      [EthereumAddress.fromHex(address)], ethClient, owner_private_key);

  if (kDebugMode) {
    print('Voter auth successfully');
  }
  return response;
}

Future<List> getCandidateNum(Web3Client ethClient) async {
  List<dynamic> result = await ask('getCandidatenNum', [], ethClient);
  return result;
}

Future<List> getTotalVotes(Web3Client ethClient) async {
  List<dynamic> result = await ask('getTotalVotes', [], ethClient);
  return result;
}

Future<List> getCandidateInfo(int index, Web3Client ethClient) async {
  List<dynamic> result =
      await ask('getCandidateInfo', [BigInt.from(index)], ethClient);
  return result;
}

Future<List<dynamic>> ask(
    String funName, List<dynamic> args, Web3Client ethClient) async {
  final contract = await loadContract();
  final ethFunction = contract.function(funName);

  final result =
      ethClient.call(contract: contract, function: ethFunction, params: args);
  return result;
}

Future<String> vote(int candidateIndex, Web3Client ethClient) async {
  var response = await callFunction(
      'vote', [BigInt.from(candidateIndex)], ethClient, voter_private_key);

  if (kDebugMode) {
    print('Vote counted succesfully');
  }
  return response;
}
