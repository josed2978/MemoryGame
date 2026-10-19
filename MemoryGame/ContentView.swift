//
//  ContentView.swift
//  MemoryGame
//
//  Created by Josed Vasquez on 10/17/26.
//

import SwiftUI

// MARK: - Memory Card Model

struct MemoryCard: Identifiable, Equatable {

    let id = UUID()
    let symbol: String

    var isFaceUp = false
    var isMatched = false
}


// MARK: - Content View

struct ContentView: View {

    // Available symbols
    private let symbols = [
        "🌎", "🚀", "🐶", "🍕", "⚽️",
        "🎮", "🌈", "🐱", "🍎", "🎸"
    ]

    // Number of pairs selected
    @State private var pairCount = 3

    // Cards currently in game
    @State private var cards: [MemoryCard] = []

    // First selected card
    @State private var firstSelectedCardID: UUID?

    // Prevents tapping additional cards
    // while two cards are being checked
    @State private var isCheckingCards = false

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {

        NavigationStack {

            VStack(spacing: 20) {

                // MARK: - Controls

                HStack {

                    Picker(
                        "Choose Size",
                        selection: $pairCount
                    ) {

                        Text("3 Pairs")
                            .tag(3)

                        Text("6 Pairs")
                            .tag(6)

                        Text("10 Pairs")
                            .tag(10)
                    }
                    .pickerStyle(.menu)
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)

                    Spacer()

                    Button {

                        resetGame()

                    } label: {

                        Text("Reset Game")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                }
                .padding(.horizontal)

                // MARK: - Card Grid

                ScrollView {

                    LazyVGrid(
                        columns: columns,
                        spacing: 8
                    ) {

                        ForEach(cards) { card in

                            CardView(card: card)

                                .onTapGesture {

                                    cardTapped(card)
                                }
                        }
                    }
                    .padding(.horizontal)
                }

                // MARK: - Game Complete

                if !cards.isEmpty &&
                    cards.allSatisfy({ $0.isMatched }) {

                    VStack(spacing: 10) {

                        Text("🎉 You Won!")
                            .font(.title)
                            .bold()

                        Button(
                            "Play Again"
                        ) {

                            resetGame()
                        }
                        .buttonStyle(
                            .borderedProminent
                        )
                    }
                    .padding()
                }
            }

            .navigationTitle("Memory Game")

            .onAppear {

                resetGame()
            }

            .onChange(of: pairCount) {

                resetGame()
            }
        }
    }


    // MARK: - Card Tapped

    private func cardTapped(
        _ tappedCard: MemoryCard
    ) {

        // Don't allow another card while
        // checking the current two.
        guard !isCheckingCards else {
            return
        }

        guard let tappedIndex =
            cards.firstIndex(
                where: {
                    $0.id == tappedCard.id
                }
            )
        else {
            return
        }

        // Ignore already matched cards.
        guard !cards[tappedIndex].isMatched else {
            return
        }

        // Ignore a card already face up.
        guard !cards[tappedIndex].isFaceUp else {
            return
        }

        // Flip card.
        withAnimation {

            cards[tappedIndex].isFaceUp = true
        }


        // MARK: First Card

        if firstSelectedCardID == nil {

            firstSelectedCardID =
                tappedCard.id

            return
        }


        // MARK: Second Card

        guard let firstID =
            firstSelectedCardID,

              let firstIndex =
            cards.firstIndex(
                where: {
                    $0.id == firstID
                }
            )
        else {

            firstSelectedCardID = nil
            return
        }

        isCheckingCards = true


        // MARK: Matching Cards

        if cards[firstIndex].symbol ==
            cards[tappedIndex].symbol {

            DispatchQueue.main.asyncAfter(
                deadline: .now() + 0.5
            ) {

                withAnimation {

                    cards[firstIndex]
                        .isMatched = true

                    cards[tappedIndex]
                        .isMatched = true
                }

                firstSelectedCardID = nil
                isCheckingCards = false
            }

        } else {

            // MARK: Non-Matching Cards

            DispatchQueue.main.asyncAfter(
                deadline: .now() + 0.8
            ) {

                withAnimation {

                    cards[firstIndex]
                        .isFaceUp = false

                    cards[tappedIndex]
                        .isFaceUp = false
                }

                firstSelectedCardID = nil
                isCheckingCards = false
            }
        }
    }


    // MARK: - Reset Game

    private func resetGame() {

        let selectedSymbols =
            Array(
                symbols.prefix(pairCount)
            )

        var newCards: [MemoryCard] = []

        for symbol in selectedSymbols {

            // Add two matching cards.
            newCards.append(
                MemoryCard(
                    symbol: symbol
                )
            )

            newCards.append(
                MemoryCard(
                    symbol: symbol
                )
            )
        }

        cards = newCards.shuffled()

        firstSelectedCardID = nil

        isCheckingCards = false
    }
}


// MARK: - Card View

struct CardView: View {

    let card: MemoryCard

    var body: some View {

        ZStack {

            // Card background
            RoundedRectangle(
                cornerRadius: 12
            )
            .fill(
                card.isFaceUp
                ? Color.white
                : Color.blue
            )

            .overlay {

                RoundedRectangle(
                    cornerRadius: 12
                )
                .stroke(
                    card.isFaceUp
                    ? Color.black
                    : Color.blue,
                    lineWidth: 2
                )
            }

            // Face of card
            if card.isFaceUp {

                Text(card.symbol)
                    .font(.system(size: 42))

            } else {

                Image(
                    systemName:
                        "questionmark"
                )
                .font(.title)
                .foregroundStyle(
                    Color.blue
                )
            }
        }

        .frame(height: 125)

        // Matching cards disappear.
        .opacity(
            card.isMatched
            ? 0
            : 1
        )

        .disabled(
            card.isMatched
        )

        .animation(
            .easeInOut,
            value: card.isFaceUp
        )

        .animation(
            .easeInOut,
            value: card.isMatched
        )
    }
}


#Preview {

    ContentView()
}
