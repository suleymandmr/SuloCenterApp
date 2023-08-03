import UIKit
import Firebase
import SDWebImage
import SideMenu
import FirebaseStorage


class SinemaViewController: UIViewController {
    
   
    @IBOutlet weak var collectionView: UICollectionView!
    
    var filmler:[String] = [String]()
    var sinemaListesi = [Sinema]()
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        let tasarim:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let genislik = self.collectionView.frame.size.width
        
        tasarim.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tasarim.minimumInteritemSpacing = 10
        tasarim.minimumLineSpacing = 10
        
        let hucreGenislik = (genislik-30)/2
        tasarim.itemSize = CGSize(width: hucreGenislik, height: hucreGenislik*1.6)
        
        collectionView!.collectionViewLayout = tasarim
        
        fetchRealtimeDatabaseData()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsSelection = true
    }
   
 
    
    func fetchRealtimeDatabaseData() {
        
            let db = Database.database().reference().child("Sinema")
            db.observeSingleEvent(of: .value) { (snapshot) in
                guard let filmsSnapshot = snapshot.children.allObjects as? [DataSnapshot] else {
                    print("Realtime Database'den veri çekerken hata oluştu.")
                    return
                }
                
                // Realtime Database verilerini sinemaListesi'ne ekleyelim
                for filmSnapshot in filmsSnapshot {
                    let id = filmSnapshot.key
                    let filmData = filmSnapshot.value as! [String: Any]
                    if let baslik = filmData["Subject"] as? String,
                       let resimAdi = filmData["Image"] as? String {
                        let film = Sinema(id: id, baslik: baslik, resimAdi: resimAdi)
                        self.sinemaListesi.append(film)
                    }
                }
                
                // Realtime Database verilerini aldıktan sonra gridview'i yenile
                self.collectionView.reloadData()
            }
        
        }
        
}

extension SinemaViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sinemaListesi.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SinemaCell", for: indexPath) as! SinemaCell
                let film = sinemaListesi[indexPath.row]
                cell.sinemaLabel.text = film.baslik
        cell.sinemaImageView.sd_setImage(with: URL(string: film.resimAdi))
                return cell
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "", sender: nil)
        photoTapped(at: indexPath)
    }
 
    
    
}
extension SinemaViewController {
    func photoTapped(at indexPath: IndexPath) {
        
        print("Photo tapped at index: \(indexPath.row)")
                
                let next = self.storyboard?.instantiateViewController(withIdentifier: "ParibuVC") as! ParibuVC
                //next.photoData = photoData
                //self.present(next, animated: true, completion: nil)
                self.navigationController?.pushViewController(next, animated: false)
            }
    
}
