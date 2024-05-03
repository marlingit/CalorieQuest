//
//  PDFDocView.swift
//  CalorieQuest
//
//  Created by Marlin on 5/2/24.
//  Copyright © 2024 Marlin Spears. All rights reserved.
//

import SwiftUI
import PDFKit

struct PDFDocView: View {
    
    @Binding var detailsViewSelected: Int
    @Binding var sheetActive: Bool
    
    @State private var showAlertMessage = false
    
    var body: some View {
        
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                Text("PDF Preview")
                    .foregroundStyle(.black)
                    .font(.custom("Urbanist", size: 24))
                    .fontWeight(.heavy)
                
                Spacer()
                
                Button {
                    detailsViewSelected = 0
                    sheetActive = false
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .scaledToFit()
                        .fontWeight(.heavy)
                        .foregroundStyle(.black)
                        .frame(width: 25)
                }
                .padding(.top, 4)
                
            }.frame(maxWidth: .infinity)
                .padding(.leading, 24)
                .padding(.trailing, 24)
                .padding(.top, 12)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    PDFKitView(pdfData: PDFDocument(data: generatePDF())!)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 24)
                    HStack {
                        Spacer()
                        
                        Button {
                            savePDF()
                        } label: {
                            Text("Save PDF")
                                .font(.system(size: 18))
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .padding()
                                .background(Color.black, in: RoundedRectangle(cornerRadius: 25))
                        }
                        .alert(alertTitle, isPresented: $showAlertMessage, actions: {
                            Button("OK") {
                                if alertTitle == "New PDF Saved!" {
                                    detailsViewSelected = 0
                                    sheetActive = false
                                }
                            }
                        }, message: {
                            Text(alertMessage)
                        })
                        
                        Spacer()
                    }
                }.frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 24)
                    .padding(.trailing, 24)
                    .padding(.top, 24)
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.top, 12)
            
            Spacer()
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    @MainActor func generatePDF() -> Data {
        
        let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y:0, width: 595, height: 842))
        let data = pdfRenderer.pdfData { context in
            context.beginPage()
            
        }
        
        return data
    }
    
    @MainActor func savePDF() {
        let fileName = "CalorieQuestPDF.pdf"
        let pdfData = generatePDF()
        
        if let documentDirectoreis = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let documentURL = documentDirectoreis.appendingPathComponent(fileName)
            do {
                try pdfData.write(to: documentURL)
                print("PDF saved at: \(documentURL)")
            } catch {
                fatalError("Error saving PDF")
            }
            
            showAlertMessage = true
            alertTitle = "New PDF Saved!"
            alertMessage = "Your new PDF is successfully saved at \(documentURL)!"
            return
        }
        
        showAlertMessage = true
        alertTitle = "PDF Not Saved!"
        alertMessage = "Your new PDF could not be saved!"
    }
}

struct PDFKitView: UIViewRepresentable {
    let pdfDocument: PDFDocument
    
    init(pdfData pdfDoc: PDFDocument) {
        self.pdfDocument = pdfDoc
    }
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = pdfDocument
        pdfView.autoScales = true
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {
        uiView.document = pdfDocument
    }
}
