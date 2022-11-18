import Foundation

// Facade Pattern

enum ClinetLevel: String, Equatable {
  case VIP
  case Normal
}

class Account {
  
  let id: UUID = UUID()
  let name: String
  let age: Int
  
  var clientLevel: ClinetLevel {
    switch name {
    case "HaminSong":
      return .VIP
    default:
      return .Normal
    }
  }
  
  init(name: String, age: Int) {
    self.name = name
    self.age = age
  }
}

class Movie {
  let name: String
  let star: Double
  let director: String
  let actors: [String]
  
  init(name: String, star: Double, director: String, actors: [String]) {
    self.name = name
    self.star = star
    self.director = director
    self.actors = actors
  }
}

protocol MovieSystem {
  func getMovie(accountType: Account, completion: @escaping ([Movie]) -> Void)
}

final class MovieSystemImpl: MovieSystem {
  func getMovie(accountType: Account, completion: @escaping ([Movie]) -> Void) {
    // some work to fetch Movie array here...
    completion(
      [
        Movie(name: "movie1", star: 3.3, director: "scallet", actors: ["e","c","a"]),
        Movie(name: "movie2", star: 4.2, director: "creamson", actors: ["a","b","q"]),
        Movie(name: "movie3", star: 4.9, director: "johanLee", actors: ["p","z","y"])
      ]
    )
  }
  
  
}

protocol ClientSystem {
  func getClientInformation(id: String, completion: @escaping ((Account) -> Void))
}

final class ClientSystemImplement: ClientSystem {
  func getClientInformation(id: String, completion: @escaping ((Account) -> Void)) {
    // some work here to get Client Information
    completion(Account(name: "HaminSong", age: 28))
  }
}

class getMovieClient {
  let movieSystem: MovieSystem
  let clientSystem: ClientSystem
  
  init(movieSystem: MovieSystem, clientSystem: ClientSystem) {
    self.movieSystem = movieSystem
    self.clientSystem = clientSystem
    
    getMovies()
  }
  
  func getMovies() {
    self.clientSystem.getClientInformation(id: "2200") { (account: Account) in
      switch account.clientLevel {
      case .VIP:
        self.movieSystem.getMovie(accountType: account) { (movieList: [Movie]) in
          movieList.forEach{(print(String(describing: $0.actors)))}
        }
      case .Normal:
        print("sorry your access is denied!")
      }
    }
  }
}

let movieClient = getMovieClient(
  movieSystem: MovieSystemImpl(),
  clientSystem: ClientSystemImplement()
)



