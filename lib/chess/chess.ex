defmodule SevastyanovChess.Chess do
  @moduledoc """
  Documentation for `SevastyanovChess.Chess`.
  """

  @emptyaccumulator []

  def run() do
    board = make_starting_board()
    draw_board(board)
  end

  def make_starting_board() do
    [
        {{:black, :rook},   :a, 1},
        {{:black, :knight}, :b, 1},
        {{:black, :bishop}, :c, 1},
        {{:black, :queen},  :d, 1},
        {{:black, :king},   :e, 1},
        {{:black, :bishop}, :f, 1},
        {{:black, :knight}, :g, 1},
        {{:black, :rook},   :h, 1},
        {{:black, :pawn},   :a, 2},
        {{:black, :pawn},   :b, 2},
        {{:black, :pawn},   :c, 2},
        {{:black, :pawn},   :d, 2},
        {{:black, :pawn},   :e, 2},
        {{:black, :pawn},   :f, 2},
        {{:black, :pawn},   :g, 2},
        {{:black, :pawn},   :h, 2},
        {{:white, :pawn},   :a, 7},
        {{:white, :pawn},   :b, 7},
        {{:white, :pawn},   :c, 7},
        {{:white, :pawn},   :d, 7},
        {{:white, :pawn},   :e, 7},
        {{:white, :pawn},   :f, 7},
        {{:white, :pawn},   :g, 7},
        {{:white, :pawn},   :h, 7},
        {{:white, :rook},   :a, 8},
        {{:white, :knight}, :b, 8},
        {{:white, :bishop}, :c, 8},
        {{:white, :queen},  :d, 8},
        {{:white, :king},   :e, 8},
        {{:white, :bishop}, :f, 8},
        {{:white, :knight}, :g, 8},
        {{:white, :rook},   :h, 8}
      ]
  end

  def draw_board(board) do
    blank = blank_board()
    newboard = format_board(board, @emptyaccumulator)
    initialoffset = 0
    b = apply_board(newboard, blank, initialoffset, @emptyaccumulator)
    :io.format(b, [])
    :ok
  end

  defp apply_board([], rest, _n, acc) do
   List.flatten(Enum.reverse([rest | acc]))
  end
  defp apply_board([{loc, piece} | t], board, n, acc) do
    {newacc, [_replaced | tail]} = Enum.split(board, loc - n - 1)
    apply_board(t, tail, loc, [get_piece(piece), newacc | acc])
  end

  defp format_board([], acc), do: Enum.sort(acc)
  defp format_board([{p, c, r} | t], acc) do
    newc = shift_col(c)
    newr = shift_row(r)
    loc = make_loc(newr, newc)
    format_board(t, [{loc, p} | acc])
  end

  defp make_loc(row, col), do: (row * 30) + col

  defp shift_row(n), do: (n * 3) - 1

  defp shift_col(:a), do: 4
  defp shift_col(:b), do: 7
  defp shift_col(:c), do: 10
  defp shift_col(:d), do: 13
  defp shift_col(:e), do: 16
  defp shift_col(:f), do: 19
  defp shift_col(:g), do: 22
  defp shift_col(:h), do: 25

  defp blank_board() do
    '  a   b  c  d  e  f  g  h   ~n' ++
    '  ░░░   ░░░   ░░░   ░░░     ~n' ++
    '1 ░░░   ░░░   ░░░   ░░░    1~n' ++
    '  ░░░   ░░░   ░░░   ░░░     ~n' ++
    '     ░░░   ░░░   ░░░   ░░░  ~n' ++
    '2    ░░░   ░░░   ░░░   ░░░ 2~n' ++
    '     ░░░   ░░░   ░░░   ░░░  ~n' ++
    '  ░░░   ░░░   ░░░   ░░░     ~n' ++
    '3 ░░░   ░░░   ░░░   ░░░    3~n' ++
    '  ░░░   ░░░   ░░░   ░░░     ~n' ++
    '     ░░░   ░░░   ░░░   ░░░  ~n' ++
    '4    ░░░   ░░░   ░░░   ░░░ 4~n' ++
    '     ░░░   ░░░   ░░░   ░░░  ~n' ++
    '  ░░░   ░░░   ░░░   ░░░     ~n' ++
    '5 ░░░   ░░░   ░░░   ░░░    5~n' ++
    '  ░░░   ░░░   ░░░   ░░░     ~n' ++
    '     ░░░   ░░░   ░░░   ░░░  ~n' ++
    '6    ░░░   ░░░   ░░░   ░░░ 6~n' ++
    '     ░░░   ░░░   ░░░   ░░░  ~n' ++
    '  ░░░   ░░░   ░░░   ░░░     ~n' ++
    '7 ░░░   ░░░   ░░░   ░░░    7~n' ++
    '  ░░░   ░░░   ░░░   ░░░     ~n' ++
    '     ░░░   ░░░   ░░░   ░░░  ~n' ++
    '8    ░░░   ░░░   ░░░   ░░░ 8~n' ++
    '     ░░░   ░░░   ░░░   ░░░  ~n' ++
    '  a   b  c  d  e  f  g  h   '
  end

  defp get_piece({:black, :rook})  , do: '♜'
  defp get_piece({:black, :knight}), do: '♞'
  defp get_piece({:black, :bishop}), do: '♝'
  defp get_piece({:black, :queen}),  do: '♛'
  defp get_piece({:black, :king}),   do: '♚'
  defp get_piece({:black, :pawn}),   do: '♟︎'
  defp get_piece({:white, :pawn}),   do: '♙'
  defp get_piece({:white, :rook}),   do: '♖'
  defp get_piece({:white, :knight}), do: '♘'
  defp get_piece({:white, :bishop}), do: '♗'
  defp get_piece({:white, :queen}),  do: '♕'
  defp get_piece({:white, :king}),   do: '♔'

end
