import UIKit
import Firebase
import SDWebImage
import SideMenu
import FirebaseStorage

class SinemaViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    var sinemaListesi = [Sinema]()
    private let storage = Storage.storage().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        fetchFirestoreData()
        
    }
    
    func fetchFirestoreData() {
        let db = Firestore.firestore()
        db.collection("photos").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Firestore'dan veri çekerken hata oluştu: \(error)")
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("Firestore'dan herhangi bir belge bulunamadı.")
                return
            }
            
            // Firestore verilerini sinemaListesi'ne ekleyelim
            for document in documents {
                let id = document.documentID
                let data = document.data()
                if let baslik = data["Image"] as? String,
                   let resimAdi = data["Subject"] as? String {
                    let film = Sinema(id: id, baslik: baslik, resimAdi: resimAdi)
                    self.sinemaListesi.append(film)
                    print(baslik)
                }
            }
            
            // Firestore verilerini aldıktan sonra gridview'i yenile
            self.collectionView.reloadData()
        }
    }
    
    
    
    // Gridview'de kaç satır olacağını belirliyoruz
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return sinemaListesi.count
     }
     
     // Her bir hücreyi dolduruyoruz
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SinemaCell
         let film = sinemaListesi[indexPath.row]
         cell.TitleLabel.text = film.baslik
         cell.imageView.image = UIImage(named: film.resimAdi)
         return cell
     }
 }
    
    
    
    

