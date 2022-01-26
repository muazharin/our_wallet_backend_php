<?php
defined('BASEPATH') or exit('No direct script access allowed');

class M_Transaction extends CI_Model
{
	public function transaction($id){
		$transaction_user_id = $this->input->post('transaction_user_id');
		$transaction_type = $this->input->post('transaction_type');
		$transaction_title = $this->input->post('transaction_title');
		$transaction_detail = $this->input->post('transaction_detail');
		$transaction_price = $this->input->post('transaction_price');
	}
}