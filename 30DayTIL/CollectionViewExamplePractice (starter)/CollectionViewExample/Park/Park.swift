

import Foundation

struct Park {
  enum Location: String, CaseIterable {//enum - CaseIterable은
    //return Park.Location.allCases 이런식으로 모든 case들을 꺼내다 쓸 수 있게 해주는 역할(ParkManager에서 사용되고있음 여기선)
    case alaska = "Alaska"
    case arizona = "Arizona"
    case california = "California"
    case colorado = "Colorado"
    case maine = "Maine"
    case montana = "Montana"
    case northCarolina = "North Carolina"
    case ohio = "Ohio"
    case utah = "Utah"
    case virginia = "Virginia"
    case washington = "Washington"
  }
  
  let location: Location
  let name: String
}
