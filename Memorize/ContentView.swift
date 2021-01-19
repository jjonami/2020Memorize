//
//  ContentView.swift
//  Memorize
//
//  Created by JJONAMI on 2021/01/15.
//

/**
 [MVVM]
 Model : "The Truth"
 1. UI Independent
 2. Data + Logic
 
 (데이터는 항상 model에서 view로 이동)
 
 View : read-only
 1. Reflects the Model ]
 2. Stateless -> 모든 state는 model에 있다
 3. Declared
 4. Reactive : Model 이 변경 될 때마다 자동은로 View를 업데이트
 
 ViewModel : glue -> bindding the  view to the model
 1. Interpreter for the data
  - notices changes in the model
  - publishes 'something changed'
 2. ViewModel을 view와 직접 대화하지 않음
 -> model이 변경되면 변경된 내용을 게시
 -> view가 해당 게시물을 subscribe
 -> 변경된게 있으면 view가 ViewModel에 변화에 대한 요청후 view에 반영, model에 전달되는 것은 없다
 3.Processes Intent (사용자의 의도)
 */

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack{
            ForEach(0..<4) { index in
                CardView(isFaceUp: false)
            }
        }
        .padding()
        .foregroundColor(.orange)
        .font(Font.largeTitle)
    }
}

struct CardView: View {
    var isFaceUp: Bool
    
    var body: some View{
        ZStack{
            if isFaceUp {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
                Text("🐶")
            } else{
                RoundedRectangle(cornerRadius: 10.0).fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
