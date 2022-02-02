<?php
defined('BASEPATH') or exit('No direct script access allowed');

class M_Transaction extends CI_Model
{
	public function transaction($id){
		$trWalletId  = $this->input->get('trWalletId');
		$trUserId = $this->input->get('trUserId');
		$trType = $this->input->get('trType');
		$tr_title = $this->input->post('transaction_title');
		$tr_detail = $this->input->post('transaction_detail');
		$tr_price = $this->input->post('transaction_price');
	}
}
