//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Barry Martin on 5/13/20.
//  Copyright © 2020 Barry Martin. All rights reserved.
//

import SwiftUI

//struct ContentView: View {
//    @State private var useRedText = false
//
//    // can also create a view as a property of your own view
//    // and use it inside
//    // can help to make body code clearer and keep complex code out
//    // but can't refer to other stored properties
//    // can do computed properties
//    let motto1 = Text("Draco dormines")
//    let motto2 = Text("nunquam titillandus")
//
//    var body: some View {
//        VStack {
//            Text("Hello World")
//                //.frame(maxWidth: .infinity, maxHeight: .infinity)
//                .padding()
//                .background(Color.red)
//                .padding()
//                .background(Color.blue)
//                .padding()
//                .background(Color.green)
//                .padding()
//                .background(Color.yellow)
//
//            Button("Hello World") {
//                self.useRedText.toggle()
//            }
//            .padding()
//            .foregroundColor(useRedText ? .red : .blue)
//
//            motto1
//                .foregroundColor(.purple)
//            motto2
//        }
//        //.edgesIgnoringSafeArea(.all)
//    }
//}

// we had 2 views that are identical apart from their text, we can
// wrap them up in a custom view like this
struct CapsuleText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .clipShape(Capsule())
    }
    
}

// custom modifier
// you want all titles to have a particular style
// use it with modifier() modifier
struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color.yellow)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
// when working with custom modifier, it's good to create an
// extension on View to make it easier to use.
// so wrap the Title modifier in an extension like this:
extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}

// Custom modifiers can do much more than just apply other existing
// modifiers – they can also create new view structure, as needed.
// Remember, modifiers return new objects rather than modifying
// existing ones, so we could create one that embeds the view
// in a stack and adds another view
struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
}

struct ContentView: View {
    var body: some View {
        VStack(spacing: 10) {
            //            Text("First")
            //                .font(.largeTitle)
            //                .padding()
            //                .foregroundColor(.white)
            //                .background(Color.blue)
            //                .clipShape(Capsule())
            //
            //            Text("Second")
            //                .font(.largeTitle)
            //                .padding()
            //                .foregroundColor(.white)
            //                .background(Color.blue)
            //                .clipShape(Capsule())
            HStack {
                CapsuleText(text: "First")
                CapsuleText(text: "Second")
            }
            
            
            Text("Test Title Modifier")
                //.modifier(Title())
                .titleStyle()
            
            Color.blue
            .frame(width: 300, height: 100)
            .watermarked(with: "Watermark")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
