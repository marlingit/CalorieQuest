//
//  PDFDocView.swift
//  CalorieQuest
//
//  Created by Marlin on 5/2/24.
//  Copyright © 2024 Marlin Spears. All rights reserved.
//

import SwiftUI
import SwiftData
import PDFKit

struct PDFDocView: View {
    
    @Binding var detailsViewSelected: Int
    @Binding var sheetActive: Bool
    
    @Environment(\.modelContext) private var modelContext
    @Query(FetchDescriptor<Day>(sortBy: [SortDescriptor(\Day.date, order: .forward)])) private var listOfAllDaysInDatabase: [Day]
    
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
            .onAppear {
                
            }
    }
    
    func getDay(aDate: Date) -> Day {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let day = listOfAllDaysInDatabase.first(where: { $0.date == dateFormatter.string(from: aDate) }) {
            return day
        }
        
        
        return Day(date: "", tracked: [Tracked]())
    }
    
    func calcCurrent() -> [String] {
        let day = getDay(aDate: Date())
        var calCount = 0.0
        var carbCount = 0.0
        var proteinCount = 0.0
        var fatCount = 0.0
        
        var strArray = [String]()
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        
        for aTracked in day.tracked ?? [Tracked]() {
            for aFood in aTracked.foods ?? [Food]() {
                if let cal = aFood.nutrients!.first(where: { $0.name.lowercased() == "calories"}) {
                    if cal.unit == "kcal" {
                        calCount += cal.amount / 1000
                    } else {
                        calCount += cal.amount
                    }
                }
                
                if let carb = aFood.nutrients!.first(where: { $0.name.lowercased() == "calories"}) {
                    carbCount += carb.amount
                }
                
                if let pro = aFood.nutrients!.first(where: { $0.name.lowercased() == "calories"}) {
                        proteinCount += pro.amount
                }
                
                if let fat = aFood.nutrients!.first(where: { $0.name.lowercased() == "calories"}) {
                        fatCount += fat.amount
                }
            }
        }
        
        strArray.append(formatter.string(from: calCount as NSNumber) ?? "0.0")
        
        return strArray
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
