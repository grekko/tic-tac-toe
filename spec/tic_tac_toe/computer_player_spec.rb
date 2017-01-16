# frozen_string_literal: true

require "helper"

RSpec.describe TicTacToe::ComputerPlayer do
  subject     { described_class.new number: 2, symbol: "π", cli: cli }
  let(:cli)   { instance_double("TicTacToe::Cli", clear: true, print: true) }
  let(:board) { TicTacToe::Board.new }

  before do
    subject.board = board
  end

  describe "#next_move" do
    it "waits 2s before responding with its next move" do
      expect(Kernel).to receive(:sleep).with(2)
      expect(subject).to receive(:pick_field).and_return(5)
      expect(subject.next_move).to eq(5)
    end
  end

  describe "#pick_field" do
    let(:corner_fields) { TicTacToe::Board::CORNER_FIELDS }
    let(:edge_fields)   { TicTacToe::Board::EDGE_FIELDS }

    context "opponent offers chance to win" do
      before do
        board.fields = [
          nil, nil, "π",
          "X", "π", nil,
          nil, nil, "X",
        ]
      end

      it "picks the winning corner" do
        expect(subject.pick_field).to eq(7)
      end
    end

    context "opponent is about to win" do
      before do
        board.fields = [
          nil, nil, "π",
          "X", "X", nil,
          nil, nil, nil,
        ]
      end

      it "defends the game" do
        expect(subject.pick_field).to eq(6)
      end
    end

    context "no obvious good move" do
      before do
        board.fields = [
          nil, nil, "π",
          "π", "X", "X",
          "X", "π", "X",
        ]
      end

      it "picks any available field" do
        expect([1, 2]).to include(subject.pick_field)
      end
    end

    context "with an empty board" do
      it "picks a random corner" do
        expect(corner_fields).to include(subject.pick_field)
      end

      context "opponent picked" do
        context "an edge" do
          before do
            board.fields = [
              nil, nil, "π",
              "X", nil, nil,
              nil, nil, nil,
            ]
          end

          it "picks the center" do
            expect(subject.pick_field).to eq(TicTacToe::Board::CENTER_FIELD)
          end
        end

        context "the center" do
          before do
            board.fields = [
              nil, nil, "π",
              nil, "X", nil,
              nil, nil, nil,
            ]
          end

          it "picks any corner" do
            expect([1, 7, 9]).to include(subject.pick_field)
          end
        end

        context "any corner" do
          before do
            board.fields = [
              nil, nil, "π",
              nil, nil, nil,
              "X", nil, nil,
            ]
          end

          it "picks any available corner" do
            expect([1, 9]).to include(subject.pick_field)
          end
        end
      end
    end

    context "with the opponent starting" do
      context "in a corner" do
        before { board.fields[corner_fields.sample] = "X" }

        it "picks the center" do
          expect(subject.pick_field).to eq(TicTacToe::Board::CENTER_FIELD)
        end
      end

      context "in the center" do
        before { board.fields[TicTacToe::Board::CENTER_FIELD] = "X" }

        it "picks any corner" do
          expect(TicTacToe::Board::CORNER_FIELDS).to include(subject.pick_field)
        end
      end

      context "on an edge" do
        let(:any_edge_field) { edge_fields.sample }
        before { board.fields[any_edge_field] = "X" }

        it "picks a corner next to the taken edge" do
          expect([any_edge_field + 1, any_edge_field - 1]).to include(subject.pick_field)
        end
      end
    end
  end

  describe "#to_s" do
    it "displays the Players name properly" do
      expect(subject.to_s).to eq("Player 2 (π, Computer)")
    end
  end
end
