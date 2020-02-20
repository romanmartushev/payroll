<?php

namespace App\Http\Controllers\OpenPayroll\Setting;

use App\Http\Controllers\Controller;
use App\Models\OpenPayroll\DeductionType;
use Illuminate\Http\Request;

class DeductionController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return view('open-payroll.settings.deduction.index');
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('open-payroll.settings.deduction.create');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     *
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $this->validate($request, [
            'name' => 'required|min:3|max:255',
        ]);

        DeductionType::create([
            'name'      => $request->name,
            'code'      => kebab_case($request->name, ''),
            'is_locked' => false,
        ]);

        flash('You have successfully create a deduction type.')->success();

        return redirect()->route('open-payroll.setting.index');
    }

    /**
     * Display the specified resource.
     *
     * @param int $id
     *
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param int $id
     *
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $type = DeductionType::findOrFail($id);

        return view('open-payroll.settings.deduction.edit', compact('type'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @param int                      $id
     *
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $this->validate($request, [
            'name' => 'required|min:3|max:255',
        ]);

        DeductionType::whereId($id)->update([
            'name'      => $request->name,
            'code'      => kebab_case($request->name, ''),
            'is_locked' => false,
        ]);

        flash('You have successfully update a deduction type.')->success();

        return redirect()->route('open-payroll.setting.index');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param int $id
     *
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        DeductionType::whereId($id)->delete();

        flash('You have successfully delete a deduction type.')->success();

        return redirect()->route('open-payroll.setting.index');
    }
}
