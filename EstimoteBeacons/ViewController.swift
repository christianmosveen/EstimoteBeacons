import UIKit

class ViewController: UIViewController, ESTBeaconManagerDelegate {

    let beaconManager:ESTBeaconManager = ESTBeaconManager()
    
    let beaconUUID:NSUUID = NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!
    let MAJOR = 1337 // SETT DENNE TIL EGEN MAJOR-ID
    
    let colors = [
        1: UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 1),
        2: UIColor(red: 255/255, green: 255/255, blue: 0/255, alpha: 1),
        3: UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beaconManager.requestAlwaysAuthorization()
        beaconManager.delegate = self
        
        var beaconRegion:ESTBeaconRegion = ESTBeaconRegion(proximityUUID: beaconUUID, identifier: "Estimote")
        
        beaconManager.startRangingBeaconsInRegion(beaconRegion)
    }
    
    func beaconManager(manager: ESTBeaconManager!, didRangeBeacons beacons: [ESTBeacon]!, inRegion region: ESTBeaconRegion!) {
        
        println("Found \(beacons.count) beacons!")
        
        let myBeacons = beacons.filter{$0.major.integerValue == self.MAJOR}
        
        if (myBeacons.count > 0) {
            let proximity = myBeacons[0].proximity.rawValue;
            self.view.backgroundColor = self.colors[proximity];
        }
    }
}

