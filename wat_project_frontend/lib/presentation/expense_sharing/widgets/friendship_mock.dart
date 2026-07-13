class FriendshipMock {
  final String userId;
  final String name;

  const FriendshipMock({required this.userId, required this.name});
}

const List<FriendshipMock> allFriendsMock = [
  FriendshipMock(userId: 'usr_alex', name: 'Alex Smith'),
  FriendshipMock(userId: 'usr_maria', name: 'Maria Garcia'),
  FriendshipMock(userId: 'usr_john', name: 'John Doe'),
  FriendshipMock(userId: 'usr_jane', name: 'Jane Doe'),
  FriendshipMock(userId: 'usr_somsak', name: 'Somsak Saetang'),
  FriendshipMock(userId: 'usr_somchai', name: 'Somchai Rakdee'),
];
