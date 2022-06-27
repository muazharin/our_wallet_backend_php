<?php
defined('BASEPATH') or exit('No direct script access allowed');

class M_Transaction extends CI_Model
{
	
	public function transaction(){
		$trWalletId  = $this->input->get('trWalletId');
		$trUserId = $this->input->get('trUserId');
		$trType = $this->input->get('trType');
		$tr_title = $this->input->post('transaction_title');
		$tr_detail = $this->input->post('transaction_detail');
		$tr_price = $this->input->post('transaction_price');
		$exist_data = $this->db->get('wallet')->row();

		if($trType == "Kredit"){
			$data["walletMoney"] = $exist_data->walletMoney+$tr_price;
		}else{
			if($exist_data->walletMoney >= $tr_price){
				$data["walletMoney"] = $exist_data->walletMoney-$tr_price;
			}else{
				$res = [
					'status' => false,
					'message' => 'Saldo tidak mencukupi!',
				];
				return $res;
			}
		}
		$this->db->where('walletId', $trWalletId);
		if($this->db->update('wallet', $data)){ // update walletMoney pada tabel wallet
			$data1 = [
				'transactionUserId' => $trUserId,
				'transactionWalletId' => $trWalletId,
				'transactionType' => $trType,
				'transactionTitle' => $tr_title,
				'transactionDetail' => $tr_detail,
				'transactionPrice' => $tr_price,
				'transactionDate' => date('Y-m-d H:i:s'),
			];
			if($this->db->insert('transactions', $data1)){ // menyimpan data transaksi
				$_id = $this->db->insert_id();
				$counts = count($_FILES['transaction_file']['name']);
				for($i=0;$i<$counts;$i++){
					if(!empty($_FILES['transaction_file']['name'][$i])){
						$_FILES['file']['name'] = $_FILES['transaction_file']['name'][$i];
						$_FILES['file']['type'] = $_FILES['transaction_file']['type'][$i];
						$_FILES['file']['tmp_name'] = $_FILES['transaction_file']['tmp_name'][$i];
						$_FILES['file']['error'] = $_FILES['transaction_file']['error'][$i];
						$_FILES['file']['size'] = $_FILES['transaction_file']['size'][$i];
			
						$config['upload_path'] = 'assets/file_tr/'; 
						$config['allowed_types'] = 'jpg|jpeg|png|gif';
						$config['max_size'] = '2000'; // max_size in kb
						$config['file_name'] = time().".png";
			
						$this->load->library('upload',$config); 
			
						if($this->upload->do_upload('file')){
							$uploadData = $this->upload->data();
							$filename = time().".png";
							$dataTrFile = [
								"tfTransactionId" => $_id,
								"tfFile" => $filename,
							];
							$this->db->insert('transactions_file',$dataTrFile);
						}
				  	}
				}
				$res = [
					'status' => true,
					'message' => 'Transaksi berhasil',
				];
			}
		}else{
			$res = [
				'status' => false,
				'message' => 'Transaksi gagal',
			];
		}
		return $res;
	}
	
	public function list_transaction(){
		$walletId = $this->input->get('walletId');
		$userId = $this->input->get('userId');
		$page = $this->input->get('page');
		if($page == null) $page = 1;

		$this->db->select('transactions.*, users.userName, users.userEmail, users.userPhoto, users.userPhone, wallet.*');
		$this->db->from('transactions');
		if($walletId != null && $walletId != ""){
			$this->db->where('transactions.transactionWalletId', $walletId);
			$this->db->join('wallet','wallet.walletId = transactions.transactionWalletId','left');
		} 
		if($userId != null && $userId != "") $this->db->where('transactions.transactionUserId', $userId);
		$this->db->join('users','users.userId = transactions.transactionUserId','left');
		$this->db->limit(10, ($page-1)*10);
		$this->db->order_by('transactions.transactionId','DESC');
		$result = $this->db->get();
		if($result){
			$data = $result->result_array();
			$data1 = [];
			for ($i=0; $i <count($data) ; $i++) { 
				
				$res = [
					'id' => $data[$i]['transactionId'],
					'userId' => $data[$i]['transactionUserId'],
					'walletId' => $data[$i]['transactionWalletId'],
					'type' => $data[$i]['transactionType'],
					'transactionDetail' => [
						'title' => $data[$i]['transactionTitle'],
						'detail' => $data[$i]['transactionDetail'],
						'price' => $data[$i]['transactionPrice'],
						'date' => $data[$i]['transactionDate'],
					],
					'userDetail'=>[
						'name' => $data[$i]['userName'],
						'email' => $data[$i]['userEmail'],
						'photo' => $data[$i]['userPhoto'],
						'phone' => $data[$i]['userPhone'],
					],
					'walletDetail'=> [
						'name'=> $data[$i]['walletName'],
						'color'=> $data[$i]['walletColor'],
					],
					'file' => $this->datafile($data[$i]['transactionId']),
				];
				array_push($data1, $res);
			}
			$res = [
				'status' => true,
				'message' => 'Berhasil menampilkan data',
				'data' => $data1,
			];
		}else{
			$res = [
				'status' => false,
				'message' => 'Gagal akses data',
			];
		}
		return $res;
	}

	public function datafile($trId) {
		$this->db->where('tfTransactionId', $trId);
		$result = $this->db->get('transactions_file')->result_array();
		$data = [];
		for ($i=0; $i <count($result) ; $i++) { 
			$res = [
				'tfId'=> $result[$i]['tfId'],
				'tfFile'=>  base_url()."assets/file_tr/".$result[$i]['tfFile'],
			];
			array_push($data, $res);
		}
		return $data;
	}
}