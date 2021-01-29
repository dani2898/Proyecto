//
//  MovieManager.swift
//  Proyecto
//
//  Created by Jessica Villa on 24/01/21.
//

import Foundation

protocol movieManagerDelegate{
    func actualizarMovie(movie: MovieModelo)
    
    func huboError(cualError: Error)
}

struct MovieManager{
    var delegado: movieManagerDelegate?
  let movieURL = "https://api.themoviedb.org/3/search/movie?api_key=00b243ce92c1049a7222cd1c4e3e7302&language=en-US"
    
    func fetchMovie(nombrePelicula: String){
        let urlConcatenada = "\(movieURL)&query=\(nombrePelicula)"
        let urlString = urlConcatenada.replacingOccurrences(of: " ", with: "+")
        print(urlString)
        
        realizarSolicitud(urlString: urlString)
    }
    
    func realizarSolicitud(urlString: String){
              //Crear url
              if let url = URL(string: urlString){
                  //crear url session
                  let session = URLSession(configuration: .default)
                  
                  //Asignar tarea a la sesión
                  
                  let tarea = session.dataTask(with: url)  {(data, respuesta, error) in
                      if error != nil {
                          self.delegado?.huboError(cualError: error!)
                          
                          return
                      }
                      
                      if let datosSeguros = data {
                          //Decodificar el objeto Json de la api
                        if let movie = self.parseJSON(MovieDat: datosSeguros){
                              self.delegado?.actualizarMovie(movie: movie)
                          }
                      
                      }
                  }
                  
                  //Empezar la tarea
                    print("Inicia la tarea")
                  tarea.resume()
              }
              
              
          }
       
       func parseJSON(MovieDat : Data) -> MovieModelo?{
               let decoder = JSONDecoder()
               do {
               
                let dataDecodificada = try decoder.decode(MovieData.self, from: MovieDat)
                print("hola")
                let id = dataDecodificada.results![0].id
                let titulo = dataDecodificada.results![0].title
                let resumen = dataDecodificada.results![0].overview
                let calificacion = dataDecodificada.results![0].vote_average
                let poster = "https://image.tmdb.org/t/p/original"+dataDecodificada.results![0].poster_path!
                let objMovie = MovieModelo(idPelicula: id!, overviewPelicula: resumen!, titlePelicula: titulo!, voteAveragePelicula: calificacion!, posterPathPelicula:poster)
                   
                   return objMovie
                   
               } catch  {
                   self.delegado?.huboError(cualError: error)
                   return nil
               }
              
           }
           
   }
