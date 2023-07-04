

#' Title 预览数据
#'
#' @param input 输入
#' @param output 输出
#' @param session 会话
#' @param dms_token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples viewfnoteserver()
krmesMachinePlanQuery <- function(input,output,session,dms_token) {


     var_dr_krmesMachinePlanUI = tsui::var_dateRange('dr_krmesMachinePlanUI')
    shiny::observeEvent(input$btn_krmesMachinePlanUI_view,
                        {
                          dates = var_dr_krmesMachinePlanUI()
                          startDate = as.character(dates[1])
                          endDate = as.character(dates[2])
                            sql = paste0("SELECT   [FBillNo] as 制令单号
      ,[FWorkshopid] as 车间
	   ,[FOperid] as 工序
	   ,[FSummary] as 机台号
      ,[FDate] as  日期
      ,[Fmaterialid] as 料号
      ,[FVeriety] as 品名
      ,[FOrderqty] as 订单量
      ,'pcs' as 生产单位
      ,[FPlanqty] as 计划数量
      ,[FOperator] as 操作员
  FROM [krmes].[dbo].[rds_mes_src_mfg_order]
  where FDate >='",startDate,"' and FDate <='",endDate,"'
  order by FDate desc,FSummary asc")
                            data = tsda::sql_select2(token = dms_token, sql = sql)
                            #显示数据
                            tsui::run_dataTable2(id = 'krmesMachinePlanUI_view_data', data = data)
                            #下载数据
                            tsui::run_download_xlsx(id = 'dl_krmesMachinePlanUI',data = data,filename = '机台派工下载.xlsx')






  })
}



#' Title 后台处理总函数
#'
#' @param input 输入
#' @param output 输出
#' @param session 会话
#' @param dms_token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples HrvServer()
krmesMachinePlanServer <- function(input,output,session,dms_token) {
  #预览数据
  krmesMachinePlanQuery(input,output,session,dms_token)

}
