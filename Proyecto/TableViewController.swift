//
//  TableViewController.swift
//  Proyecto
//
//  Created by Jessica Villa on 28/01/21.
//

import UIKit
import CoreData

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var recomendaciones = [Recomendacion]()
    var recibirUsuario: String? = ""
    var contador = 0
    @IBOutlet weak var table: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        table.register(UINib(nibName: "PeliculaTableViewCell", bundle: nil), forCellReuseIdentifier: "cellTable")
               
        table.dataSource = self
        table.delegate = self
        // Do any additional setup after loading the view.
        cargarInfoCoreData()
              
              self.table.reloadData()        // Do any additional setup after loading the view.
          }

          override func viewWillAppear(_ animated: Bool) {
              cargarInfoCoreData()
              table.reloadData()
          }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recomendaciones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = table.dequeueReusableCell(withIdentifier: "cellTable") as! PeliculaTableViewCell
        
    
            let imageUrlString = recomendaciones[indexPath.row].poster

            let imageUrl = URL(string: imageUrlString!)!

            let imageData = try! Data(contentsOf: imageUrl)
            print("de core data")
            print(recomendaciones[0])
            
            celda.poster.image = UIImage(data: imageData)
            celda.peliculaLabel.text = recomendaciones[indexPath.row].nombrePelicula
            celda.opinionTextView.text = recomendaciones[indexPath.row].opinion
            return celda
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        contador = 0
           if editingStyle == .delete{
            
            context.delete(recomendaciones[indexPath.row])
               guardarRecomendacion()
               
               self.cargarInfoCoreData()
                self.table.reloadData()
                
                
            
           }
           
          
          // tabla.reloadData()
       }
    
    func guardarRecomendacion(){
            do {
                try context.save()
                print("Se guardo correctamente")
                self.cargarInfoCoreData()
                
            }catch let error as NSError{
                print("Error al guardar en la base de datos \(error.localizedDescription)")
            }
            
        }
    func cargarInfoCoreData(){
          
          let fetchRequest : NSFetchRequest <Recomendacion> = Recomendacion.fetchRequest()
          
          do{
              recomendaciones = try context.fetch(fetchRequest)
              
          } catch let error as NSError {
              print("Error al cargar la bd \(error.localizedDescription)")
          }
      }
}
