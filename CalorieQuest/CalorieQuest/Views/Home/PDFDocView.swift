//  PDFDocView.swift
//  CalorieQuest
//
//  Created by Group 11: Vijay Vadi, Brighton Young, and Marlin Spears.
//  Copyright © 2024 Vijay, Brighton, and Marlin. All rights reserved.
//

import SwiftUI
import SwiftData
import PDFKit

struct PDFDocView: View {
    
    @Binding var detailsViewSelected: Int
    @Binding var sheetActive: Bool
    
    @Environment(\.modelContext) private var modelContext
    @Query(FetchDescriptor<Day>(sortBy: [SortDescriptor(\Day.date, order: .forward)])) private var listOfAllDaysInDatabase: [Day]
    
    @State private var countArray = ["0.0", "0.0", "0.0", "0.0"]
    
    @AppStorage("calorieTarget") var calories: String = ""
    @AppStorage("carbohydrateTarget") var carbohydrates: String = ""
    @AppStorage("proteinTarget") var proteins: String = ""
    @AppStorage("fatTarget") var fats: String = ""
    
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
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear {
                countArray = calcCurrent()
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
                
                if let carb = aFood.nutrients!.first(where: { $0.name.lowercased() == "total carbohydrate"}) {
                    carbCount += carb.amount
                }
                
                if let pro = aFood.nutrients!.first(where: { $0.name.lowercased() == "protein"}) {
                        proteinCount += pro.amount
                }
                
                if let fat = aFood.nutrients!.first(where: { $0.name.lowercased() == "total fat"}) {
                        fatCount += fat.amount
                }
            }
        }
        
        strArray.append(formatter.string(from: calCount as NSNumber) ?? "0.0")
        strArray.append(formatter.string(from: carbCount as NSNumber) ?? "0.0")
        strArray.append(formatter.string(from: proteinCount as NSNumber) ?? "0.0")
        strArray.append(formatter.string(from: fatCount as NSNumber) ?? "0.0")
        return strArray
    }
    
    @MainActor func generatePDF() -> Data {
        
        let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y:0, width: 595, height: 842))
        let data = pdfRenderer.pdfData { context in
            context.beginPage()
            
            alignText(value: "CalorieQuest", x: 0, y: 30, width: 595, height: 150, alignment: .center, textFont: UIFont(name: "Urbanist", size: 50) ?? UIFont.systemFont(ofSize: 50, weight: .bold))
            
            alignText(value: "Current Calorie Count: \(countArray[0]) / \(calories == "0" ? "Not Set" : calories) cal\nCurrent Carbohydrate Count: \(countArray[1]) / \(carbohydrates == "0" ? "Not Set" : carbohydrates) g\nCurrent Protein Count: \(countArray[2]) / \(proteins == "0" ? "Not Set" : proteins) g\nCurrent Total Fat Count: \(countArray[3]) / \(fats == "0" ? "Not Set" : fats) g\n", x: 0, y: 150, width: 595, height: 595, alignment: .left, textFont: UIFont(name: "Urbanist", size: 30) ?? UIFont.systemFont(ofSize: 30, weight: .bold))
            
        }
        
        return data
    }
    
    func alignText(value: String, x: Int, y: Int, width: Int, height: Int, alignment: NSTextAlignment, textFont: UIFont) {
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.alignment = alignment
        
        let attributes = [NSAttributedString.Key.font: textFont, NSAttributedString.Key.paragraphStyle: paragraphStyle]
        
        let textRect = CGRect(
            x: x,
            y: y,
            width: width,
            height: height
        )
        
        value.draw(in: textRect, withAttributes: attributes)
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
