class VotingBooth {

  ArrayList<Integer> votes; // a collection of all votes
  boolean voteIsDone; // whether or not the vote is closed or not closed
  
  VotingBooth() {
    // initialize the previously declared variables
    votes = new ArrayList<Integer>(10);
    voteIsDone = false;
  }
  
  void vote(int number) {
    // recieve a number corresponding to a vote and make sure the vote is still open before adding it to the collection
    if (!voteIsDone) votes.add(number);
    // make sure to close the vote if the cap is reached
    if (votes.size() == 10) voteIsDone = true;
  }
  
  void reset() {
    // reset the vote, clearing the list of votes and re-opening the vote
    votes.clear();
    voteIsDone = false;
  }
  
}
