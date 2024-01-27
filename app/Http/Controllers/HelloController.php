<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Support\Facades\Request;

class HelloController extends Controller
{

    public function index()
    {
        $user = User::all();
        return response()->json(['message' => 'LISTA!', 'data' => $user]);
    }

    public function store(Request $request)
    {
        try {
            $validatedData = $request->validate([
                'name' => 'required|max:255',
                'email' => 'required|email|unique:users',
                'password' => 'required'
            ]);

            $user = User::create([
                'name' => $validatedData['name'],
                'email' => $validatedData['email'],
                'password' => bcrypt($validatedData['password']),
            ]);

            return response()->json(['message' => 'Usuário criado com sucesso!', 'data' => $user], 201);

        } catch (\Exception $e) {
            return response()->json(['message' => $e->getMessage()], 500);
        }
    }

    public function show($id)
    {
        try {
            foreach (range(21, 300) as $i) {
                $seconds = rand(1, 1);
                sleep($seconds);
                echo 'teste' . $i . PHP_EOL;

                $user = User::findOrFail($id);
            }
            return response()->json(['message' => 'Detalhes do Usuário', 'data' => $user]);

        } catch (\Exception $e) {
            return response()->json(['message' => 'Usuário não encontrado.'], 404);
        }
    }

    public function update(Request $request, $id)
    {
        try {
            $user = User::findOrFail($id);

            $validatedData = $request->validate([
                'name' => 'sometimes|max:255',
                'email' => 'sometimes|email|unique:users,email,' . $id,
                'password' => 'sometimes'
            ]);

            $user->update($validatedData);

            return response()->json(['message' => 'Usuário atualizado com sucesso!', 'data' => $user]);
        } catch (\Exception $e) {
            return response()->json(['message' => $e->getMessage()], 500);
        }
    }

    public function destroy($id)
    {
        try {
            $user = User::findOrFail($id);
            $user->delete();
            return response()->json(['message' => 'Usuário deletado com sucesso!']);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Usuário não encontrado.'], 404);
        }
    }
}
