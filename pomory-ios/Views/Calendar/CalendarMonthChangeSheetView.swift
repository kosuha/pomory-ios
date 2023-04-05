//
//  MonthChangeSheet.swift
//  pomory-ios
//
//  Created by Seonho Kim on 2023/04/02.
//

import SwiftUI

struct CalendarMonthChangeSheetView: View {
    @ObservedObject var calendarViewModel: CalendarViewModel
    @State var year: Int
    @State var month: Int
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 100)
                .fill(Color(hex: 0xEAE8EB))
                .frame(width: 60, height: 5)
            
            VStack {
                HStack {
                    if (year <= 1900) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundColor(Color(hex: 0xB0B8C1))
                    } else {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 22, weight: .semibold))
                            .onTapGesture {
                                year -= 1
                                Vibration.selection.vibrate()
                            }
                    }
                    
                    Spacer()
                    Text(String(year))
                        .font(.system(size: 22, weight: .bold))
                    Spacer()
                    
                    if (year >= Int(dateToString(date: Date(), format: "yyyy"))! + 1) {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundColor(Color(hex: 0xB0B8C1))
                    } else {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 22, weight: .semibold))
                            .onTapGesture {
                                year += 1
                                Vibration.selection.vibrate()
                            }
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 37, trailing: 20))
                
                VStack {
                    ForEach(0..<3) { i in
                        HStack {
                            ForEach(0..<4) { j in
                                HStack {
                                    Spacer(minLength: 1)
                                    if (month - 1 == i * 4 + j) {
                                        Text(Constants.monthsTextUppercaseList[i * 4 + j])
                                            .frame(width: 70, height: 43)
                                            .font(.system(size: 16, weight: .heavy))
                                            .padding(EdgeInsets(top: 5, leading: 7, bottom: 5, trailing: 7))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 50)
                                                    .stroke(.black, lineWidth: 1.2)
                                            )
                                    } else {
                                        Text(Constants.monthsTextUppercaseList[i * 4 + j])
                                            .frame(width: 70, height: 43)
                                            .font(.system(size: 16, weight: .semibold))
                                            .padding(EdgeInsets(top: 5, leading: 7, bottom: 5, trailing: 7))
                                        
                                    }
                                    
                                    Spacer(minLength: 1)
                                }
                                .onTapGesture {
                                    month = i * 4 + j + 1
                                    Vibration.selection.vibrate()
                                }
                            }
                        }
                    }
                }
            }
            .padding(EdgeInsets(top: 33, leading: 24, bottom: 43, trailing: 24))
            
            Button(action: {
                calendarViewModel.setSelectedMonth(year: String(year), month: String(month))
                dismiss()
            }) {
                Text("확인")
                    .frame(width: 350, height: 56)
                    .background(.black)
                    .cornerRadius(50)
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 18, leading: 161, bottom: 18, trailing: 161))
            }
            
            Spacer()
        }
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
        
    }
}
