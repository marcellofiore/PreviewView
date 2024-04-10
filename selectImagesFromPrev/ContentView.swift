//
//  ContentView.swift
//  selectImagesFromPrev
//
//  Created by Marcello Fiore on 05/04/24.
//

import SwiftUI

struct ContentView: View {
    struct CustomImage: Hashable {
        let image: UIImage
        let id = UUID()
    }

    var images: [CustomImage] = []
    @State var selected: [CustomImage] = []

    var imageInPreview: UIImage {
        if !selected.isEmpty, let lastSelecter = selected.last {
            return lastSelecter.image
        } else {
            return images[0].image // no images selected, selezionare un immagine che non ha a che fare con la galleria (placeholder skeleton)
        }
    }

    init(images: [UIImage]) {
        self.images = images.map({ image in
            CustomImage(image: image)
        })
    }

    var body: some View {
        VStack {
            Image(uiImage: imageInPreview )
                .resizable()
                //.scaledToFit()
                .frame(maxWidth: .infinity)

            ScrollView(.horizontal) {
                HStack(alignment: .center, spacing: 10) {
                    ForEach(images, id: \.id) { value in
                        Image(uiImage: value.image)
                        .resizable()
                        .frame(width: 80)
                        .border(isSelected(value) ? Color.red : .clear, width: 5)
                        .frame(width: 80)
                        .onTapGesture(perform: {
                            if selected.contains(value) {
                                let index = selected.firstIndex{ $0 == value }
                                guard let index else { return }
                                // remove item only if more then 1 record already exist
                                if selected.first != value {
                                    selected.remove(at: index)
                                }
                            } else {
                                selected.append(value)
                            }
                        })

                    }

                }
                .padding(.horizontal, 10)
                .frame(height: 80)
            }

        }
        .onAppear {
            // Segna il primo record come selezionato
            if let firstSelected = self.images.first {
                selected.append(firstSelected)
            }
        }
    }

    func isSelected(_ value: CustomImage) -> Bool {
        return selected.contains(value)
    }
}

let imagesMock = [
    UIImage(named: "mockImage")!,
    UIImage(named: "mock2")!,
    UIImage(named: "mockImage")!,
    UIImage(named: "mockImage")!
]
#Preview {
    ContentView(images: imagesMock)
}
