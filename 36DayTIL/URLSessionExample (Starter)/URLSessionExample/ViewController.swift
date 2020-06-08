

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var imageView: UIImageView!
    private let imageUrlStr = "https://loremflickr.com/860/640/cat"
    
    
    // MARK: - Sync method
    
    @IBAction private func syncMethod() {
        print("\n---------- [ syncMethod ] ----------\n")
        let url = URL(string: imageUrlStr)!
        DispatchQueue.global().async {//이렇게 쓰면 비동기 방식
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }
            
            //    if let data = try? Data(contentsOf: url) {//url로 접근해서 Data를 가져오는것 , 동기 방식임
            //        imageView.image = UIImage(data: data)
        }
    }
    
    
    // MARK: - URLComponents
    
    @IBAction private func urlComponentsExample(_ sender: Any) {
        print("\n---------- [ urlComponentsExample ] ----------\n")
        /*
         http://username:password@www.example.com:80/index.html?key1=value1&key2=value2#myFragment
         */
        // 위 URL 구성을 보고 URLComponents의 각 파트를 수정해 위 구성과 같도록 만들어보기
        
        var components = URLComponents()
        components.scheme = "http"
        print(components)
        components.user = "username"
        print(components)
        components.password = "password"
        print(components)
        components.host = "www.example.com"
        print(components)
        components.port = 80
        print(components)
        components.path = "/index.html"    // path는 /로 시작해야 함
        print(components)
        components.query = "key1=value1&key2=value2"
        print(components)
        components.fragment = "myFragment"
        print(components)
        
//        var comp = URLComponents(string: //한번에 url을 작성하고 내용을 일부 바꾸고싶을 때 이렇게 사용
//            "http://username:password@www.example.com:80/index.html?key1=value1&key2=value2#frag")
//        comp?.queryItems = [
//            URLQueryItem(name: "name", value: "tory"),
//            URLQueryItem(name: "age", value: "5"),
//        ]
//        print(comp?.url?.absoluteString ?? "")
    
    }
    
    
    
    // MARK: - URL Encoding Example
    //아스키코드가 아니면 인코딩 필요. 그때 여기부분을 이용
    @IBAction private func urlEncodingExample() {
        print("\n---------- [ urlEncodingExample ] ----------\n")
//        let urlStringE = "https://search.naver.com/search.naver?sm=top_hty&fbm=0&ie=utf8&query=swift"
        //    if let url = URL(string: urlStringE) {
        //        print(url)
        //    } else {
        //        print("Nil")
        //    }
        //영어주소
        let urlStringE = "https://search.naver.com/search.naver?query=swift"
        print(URL(string: urlStringE) ?? "Nil")
        
        //한글주소
        let urlStringK = "https://search.naver.com/search.naver?query=한글"
        print(URL(string: urlStringK) ?? "Nil")//Nil나옴, 퍼센트 인코딩을 통해 바꿔줘야함
        
        //한글주소 -> 퍼센트 인코딩
        let str = "https://search.naver.com/search.naver?sm=top_hty&fbm=0&ie=utf8&query=한글"
        let queryEncodedStr = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let convertedURL = URL(string: queryEncodedStr)!
        //%ED%95%9C%EA%B8%80 프린트에서 이렇게 나오는게 "한글"의 아스키코드화임
        print(convertedURL)
        
        //URL -> String
        let encodedUrlString = "https://example.com/#color-%23708090" //%23 = #과 같음
        
        // 퍼센트 인코딩 제거
        print(encodedUrlString.removingPercentEncoding ?? "") //%23 -> #으로
        
        // String -> URL
        let originalString = "color-#708090"
        //    var allowed = CharacterSet.urlFragmentAllowed   ----> #그대로 쓰고 싶을땐 이렇게 추가
        //    allowed.insert("#")
        //    let encodedString = originalString.addingPercentEncoding(withAllowedCharacters: allowed)!
        
        let encodedString = originalString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        print(encodedString) // # -> %23
    }
    
    
    
    // MARK: - Session Configuration
    
    @IBAction private func sessionConfig(_ sender: Any) {
        print("\n---------- [ Session Configuration ] ----------\n")
        _ = URLSessionConfiguration.default
        _ = URLSessionConfiguration.ephemeral// 데이터로 남기지않는
        _ = URLSessionConfiguration.background(withIdentifier: "kr.giftbot.example.backgroundConfig")//백그라운드에서 사용할 수 있는
        
        let sessionConfig = URLSessionConfiguration.default
        
        sessionConfig.allowsCellularAccess = false //기본값 true , wifi만 사용가능하도록 만드는 커맨드
        sessionConfig.httpMaximumConnectionsPerHost = 5 //host당 최대 몇개의 연결을 유지할것인가, 기본값 4
        sessionConfig.timeoutIntervalForRequest = 20 //기본값 60초,요청할 때 최대 몇초까지 허용할 지
        sessionConfig.requestCachePolicy = .reloadIgnoringLocalCacheData //내가원하는 캐쉬정책 설정, 여기선 항상원본에 접근하게하는 커맨드(reloadIgnoringLocalCacheData) , 기본값 .useProtocolCachePolicy
        sessionConfig.waitsForConnectivity = true //기본값 false , 네트워크가 일시적으로 불안정하거나 할때 연결을 한번 시도해보고 연결이 실패했을 때 실패를 바로 반환할것인지 연결될 때까지 기다렸다가 시도해보는것
        
        //기본캐쉬 = URLCache.shared
        //여기선 메모리16kb = 16384 , 메모리 256mb = 268,435,456 를 입력해놓은것
        let myCache = URLCache(memoryCapacity: 16_384, diskCapacity: 268_435_456, diskPath: nil)
        sessionConfig.urlCache = myCache
        
        let cache = URLCache.shared
        sessionConfig.urlCache = cache
        
        print(cache.memoryCapacity) //500 KB
        print(cache.diskCapacity) // 약 9.5MB
        
        print(cache.currentMemoryUsage)// 현재사용중인 캐쉬 0
        print(cache.currentDiskUsage) //
        
        cache.removeAllCachedResponses()//저장된 캐시들을 삭제하는
        
        //저장경로 -> (user home directory)/Library/Caches/(application bundle id)/ 에 파일형태로 저장
        
//        let mySession = URLSession.shared.dataTask(with: sessionConfig) 방법1
        let mySession = URLSession(configuration: sessionConfig)//방법2
        
        let url = URL(string: imageUrlStr)!
        let task = mySession.dataTask(with: url) {
            [weak self] (data, response, error) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self?.imageView.image = UIImage(data: data)!
                print("download completed")
            }
        }
        task.resume()
    }
    
    
    // MARK: - Get, Post, Delete
    
    // https://jsonplaceholder.typicode.com/ // 내 코드가 제대로 작동되는지 테스트 해볼 수 있는 곳
    
    @IBAction func requestGet(_ sender: Any) {
        print("\n---------- [ Get Method ] ----------\n")
        let todoEndpoint = "https://jsonplaceholder.typicode.com/todos/1"
        guard let url = URL(string: todoEndpoint) else { return }
        
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            guard error == nil else { return print(error!.localizedDescription) }
            guard let response = response as? HTTPURLResponse, //HTTPURLResponse로 타입캐스팅을 해줘야 아래 statusCode를 불러올 수 있음
                (200..<300).contains(response.statusCode),
                response.mimeType == "application/json" //mimetype = 실제 데이터로 들어오는 내용이 어떤 타입인지 나타내는 것
                else { return }
            guard let data = data else { return print("No Data") }
            
            //https://jsonplaceholder.typicode.com/todos/1 에 내용을 가져온다고 생각하면됨
            guard let todo = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                let todoID = todo["id"] as? Int,
                let todoTitle = todo["title"] as? String
                else { return print("Could not get parsed data") }
            
            print("ID: ", todoID)
            print("Title: ", todoTitle)
        }
        task.resume()
    }
    
    
    @IBAction func requestPost(_ sender: Any) {
        print("\n---------- [ Post Method ] ----------\n")
        let todoEndpoint = "https://jsonplaceholder.typicode.com/todos"
        guard let todosURL = URL(string: todoEndpoint) else { return }
        
        let newToDo : [String: Any] = ["title" : "My ToDo", "userID": "20"]
        //Dictionary를 데이터 형태로 바꾸는 작업 (인터넷으로 보내기 위해서)
        guard let jsonTodo = try? JSONSerialization.data(withJSONObject: newToDo) else { return }
        
        var urlRequest = URLRequest(url: todosURL)//요청할 때
        urlRequest.httpMethod = "POST" //httpMethod = 등록에 대한 요청
        urlRequest.httpBody = jsonTodo //httpBody =  전달할 내용
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data,
                let newItem = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
                else { return }
            print(newItem)
            if let id = newItem["id"] as? Int {
                print(id)
            }
        }
        task.resume()
    }
    
    @IBAction func requestDelete(_ sender: Any) {
        print("\n---------- [ Delete Method ] ----------\n")
        let todoEndpoint = "https://jsonplaceholder.typicode.com/todos/1"
        
        let url = URL(string: todoEndpoint)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE" //지우기만 하면되니까 httpBody는 필요없음
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else { return print(error!.localizedDescription)}
            guard let data = data else { return print("No Data") }
            print("Delete ok")
            
            if let res = response as? HTTPURLResponse {
                print(res.statusCode)
            }
            
            if let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                print(data)
                print(jsonObject)
            }
        }
        task.resume()
    }
}

