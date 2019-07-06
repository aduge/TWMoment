//
//  TWMomentTests.swift
//  TWMomentTests
//
//  Created by Aduge on 2019/7/6.
//  Copyright © 2019 Aduge. All rights reserved.
//

import XCTest

class TWMomentTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // 测试网络请求
    func testBuildRequest() {
        let task = TWHttpNetwork.get(urlString: "https://thoughtworks-mobile-2018.herokuapp.com/user/jsmith") { (data :Optional<Any>?) in
            XCTAssertNotNil(data!)
        }
        XCTAssertNotNil(task)
    }
    
    // 测试调整图片大小
    func testGetSingleSize() {
        let size: CGSize = TWUtility.getSingleSize(singleSize: CGSize(width: 500, height: 315))
        XCTAssertNotNil(size)
    }
    
    // 测试设置图片
    func testSetImage() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: -100, width: 320, height: 270))
        imageView.setWebImage(url: "https://thoughtworks-mobile-2018.herokuapp.com/images/user/profile-image.jpg", defaultImage: nil, isCache: true)
        XCTAssertNotNil(imageView.image)
    }
    

}
