<?php

namespace App\Http\Controllers;

use App\Models\Tank;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class TankController extends Controller
{
    public function index()
    {
        return response()->json(Auth::user()->tanks, 200);
    }

    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'name' => 'required|string|max:255',
            'volume_gallons' => 'required|numeric|min:0.1',
            'water_type' => 'required|in:freshwater,saltwater,brackish',
            'aquascape_style' => 'nullable|string|max:255',
            'setup_date' => 'nullable|date',
        ]);

        $tank = Auth::user()->tanks()->create($validatedData);

        return response()->json($tank, 201);
    }

    public function update(Request $request, Tank $tank)
    {
        if ($tank->user_id !== Auth::id()) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $validatedData = $request->validate([
            'name' => 'sometimes|required|string|max:255',
            'volume_gallons' => 'sometimes|required|numeric|min:0.1',
            'water_type' => 'sometimes|required|in:freshwater,saltwater,brackish',
            'aquascape_style' => 'nullable|string|max:255',
            'setup_date' => 'nullable|date',
        ]);

        $tank->update($validatedData);

        return response()->json($tank, 200);
    }

    public function destroy(Tank $tank)
    {
        if ($tank->user_id !== Auth::id()) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $tank->delete();

        return response()->json(null, 204);
    }
}