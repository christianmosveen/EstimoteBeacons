import UIKit

class ViewController: UIViewController, ESTBeaconManagerDelegate {

    let constants:Constants = Constants()
    let beaconManager:ESTBeaconManager = ESTBeaconManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beaconManager.requestAlwaysAuthorization()
        beaconManager.delegate = self
        
        var beaconRegion:ESTBeaconRegion = ESTBeaconRegion(proximityUUID: constants.beaconUUID, identifier: "Estimote")
        
        beaconManager.startRangingBeaconsInRegion(beaconRegion)
    }
    
    func beaconManager(manager: ESTBeaconManager!, didRangeBeacons beacons: [ESTBeacon]!, inRegion region: ESTBeaconRegion!) {
        
        println("Found \(beacons.count) beacons!")
        
        let myBeacons = beacons.filter{$0.major.integerValue == self.constants.MAJOR}
        
        if (myBeacons.count > 0) {
            let proximity = myBeacons[0].proximity.rawValue;
            self.view.backgroundColor = constants.colors[proximity];
        }
    }
}

